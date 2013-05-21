require 'puppet/face'

Puppet::Face.define(:cloudwatch, '0.0.1') do
    summary     "Puppet AWS CloudWatch"
    description "Allows fine-grained control over Amazon Web Services' CloudWatch API"
end
