class Chef
  class Resource::GunicornStartupDjango < Resource
    include Poise

    actions(:create, :remove)

    attribute(:name, template: true, default_source: 'django.sh.erb')
    attribute(:path, kind_of: String, default: '/bin')
    attribute(:num_workers, kind_of: [Integer,String], default: 3)

    attribute(:user, kind_of: String, 
              default: lazy{ node[:gunicorn_startup][:django][:user] })
    attribute(:group, kind_of: String, 
              default: lazy{ node[:gunicorn_startup][:django][:group] })
    attribute(:sockfile, kind_of: String,
              default: lazy{ node[:gunicorn_startup][:django][:sockfile] })
    attribute(:djangodir, kind_of: String,
              default: lazy{ node[:gunicorn_startup][:django][:djangodir] })
    attribute(:django_settings_module, kind_of: String, 
              default: lazy{ node[:gunicorn_startup][:django][:django_settings_module] || nil })
    attribute(:django_wsgi_module, kind_of: String, 
              default: lazy{ node[:gunicorn_startup][:django][:django_wsgi_module] || nil })
    attribute(:activate_path, kind_of: String, 
              default: lazy{ node[:gunicorn_startup][:django][:active_path] || nil })
    attribute(:gunicorn_path, kind_of: String,
              default: lazy{ node[:gunicorn_startup][:django][:gunicorn_path] || nil })
  end

  class Provider::GunicornStartupDjango < Provider
    include Poise

    def action_create
      converge_by("enable resource #{new_resource.name}") do
        resource = new_resource.to_hash
        resource[:user] ||= new_resource.name
        resource[:group] ||= new_resource.name
        resource[:django_settings_module] ||= "#{new_resource.name}.settings" 
        resource[:django_wsgi_module] ||= "#{new_resource.name}.wsgi" 
        resource[:num_workers] ||= new_resource.num_workers

        notifying_block do
          template "#{new_resource.path}/#{resource[:name]}_django" do
            cookbook resource[:cookbook] || 'gunicorn_startup'
            user resource[:user]
            group resource[:group]
            source 'django.sh.erb'
            variables resource
            mode 0755
          end
        end
      end

      def action_remove
        cookbook_file "#{new_resource.path}/#{new_resource.name}_django" do
          action :delete
        end
      end
    end
  end
end
