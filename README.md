gunicorn\_startup Cookbook
=========================
Extends opscode-ookbooks/gunicorn cookbook to a LWRP for providing a helpful startup command for gunicorn that can be customized through chef automated deployments.

> https://github.com/opscode-cookbooks/gunicorn.git

Requirements
------------
- opscode-cookbooks/gunicorn v1.0.0 (https://github.com/opscode-cookbooks/gunicorn.git)
- poise/poise v1.0.10 (https://github.com/poise/poise)

Attributes
----------
node["gunicorn\_startup"]["django"] contains the following attributes:

- :name -- default "nil". Must be set.
- :djangodir -- default "nil". Must be set.
- :sockfile -- default "nil". Must be set.
- :user -- defaults to :name.
- :group -- defaults to :name.
- :num\_workers -- defaults to "3".
- :django\_settings\_module -- defaults to "#{name}.settings"
- :django\_wsgi\_module -- defaults to "#{name}.wsgi"
- :active\_path -- defaults to "nil". Must be set.
- :gunicorn\_path -- defaults to "nil". Must be set.

Usage
-----
#### LWRP gunicorn\_startup\_django
Includes a startup bash script in /bin/ and requires an existing gunicorn django deploy. Many of the attributes need to be set manually or else the LWRP will fail.

Only works with linux

Sets the above attributes

Contributing
------------
e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add\_component\_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
License: Apache License 2.0
Authors: Zach "zpallin" Pallin
