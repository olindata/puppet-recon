require 'puppet/cloudpack'
require 'puppet/face/cloudwatch'
require 'fog'

Puppet::Face.define :cloudwatch, '0.0.1' do
    #action :createmetric do
        #summary 'Create a CloudWatch metric.'

        #Puppet::CloudPack.add_list_options(self)

        #when_invoked do |options|
            #cw = Fog::AWS::CloudWatch.new(
                #:region => options[:region]
            #)

            #metric = cw.metrics.create(
            #)
        #end
    #end

    action :createalarm do
        summary 'Create a CloudWatch alarm.'

        Puppet::CloudPack.add_list_options(self)

        when_invoked do |options|
            cw = Fog::AWS::CloudWatch.new(
                :region => options[:region]
            )

            alarm = cw.alarms.create(
                :id => 'testalarm',
                :comparison_operator => 'GreaterThanThreshold',
                :metric_name => 'CPUUtilization',
                :period => '60',
                :statistic => 'Average',
                :threshold => '40'
            )
        end
    end
end
