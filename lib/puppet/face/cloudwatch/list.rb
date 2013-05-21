require 'puppet/cloudpack'
require 'puppet/face/cloudwatch'
require 'fog'

Puppet::Face.define :cloudwatch, '0.0.1' do
    #action :metrics do
        #summary "List CloudWatch metrics."

        #Puppet::CloudPack.add_list_options(self)

        #when_invoked do |options|
            #cw = Fog::AWS::CloudWatch.new(
                #:region => options[:region]
            #)

            #cw.metrics
        #end

        #when_rendering :console do |value|
            #value.collect do |hash|
                #puts YAML::dump(hash)
            #end
        #end
    #end

    action :alarms do
        summary "List CloudWatch alarms."

        Puppet::CloudPack.add_list_options(self)

        when_invoked do |options|
            cw = Fog::AWS::CloudWatch.new(
                :region => options[:region]
            )

            cw.alarms
        end

        when_rendering :console do |value|
            value.collect do |hash|
                puts YAML::dump(hash)
            end
        end
    end
end
