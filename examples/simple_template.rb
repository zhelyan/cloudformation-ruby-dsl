#!/usr/bin/env ruby
require 'bundler/setup'
require 'cloudformation-ruby-dsl/dsl'

extension = File.join(__dir__, "simple_template_extension.rb")
dsl = TemplateDSL.new({region: 'eu-west-1'}, [ extension ])
dsl.template do
  @stack_name = 'hello-bucket-example'

  parameter 'Label',
            :Description => 'The label to apply to the bucket.',
            :Type => 'String',
            :Default => params['Label'],
            :UsePreviousValue => true

  resource "HelloBucket",
            :Type => 'AWS::S3::Bucket',
            :Properties => {
              :BucketName => ref('Label')
            }

  sns_topic "BucketUpdates"

end
