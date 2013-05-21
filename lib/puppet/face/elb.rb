require 'puppet/face'

Puppet::Face.define(:elb, '0.0.1') do
    summary     "View and manage AWS Elastic Load Balancers"
    description "This subcommand provides a commandline interface to work with EC2 load balancers."
end
