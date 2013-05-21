require 'puppet/face'

Puppet::Face.define(:autoscale, '0.0.1') do
    summary     "Puppet AWS Autoscaler"
    description "Allows fine-grained control over Amazon Web Services' Autoscale API"
end
