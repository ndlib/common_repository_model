require 'equivalent-xml'

module CommonRepositoryModel
  module TestSupport
    def assert_fedora_datastream(object, expected_body, datastream_name)
      base_url = ActiveFedora.config.credentials[:url]
      rels_ext_url = File.join(
        base_url, 'objects', object.pid,
        'datastreams', datastream_name, 'content'
      )
      response = RestClient.get(rels_ext_url)

      assert_xml_equivalent(response.body, expected_body)
    end

    def assert_xml_equivalent(expected_string, actual_string, options = {})
      options.reverse_merge!(normalize_whitespace: true)
      expected = Nokogiri::XML(expected_string)
      actual = Nokogiri::XML(actual_string)
      EquivalentXml.equivalent?(expected, actual, options) {|na,ne,is_equal|
        assert is_equal, "Expected/Actual:\n\t#{na}\n\t#{ne}"
      }
    end

    def assert_rels_ext(subject, predicate, objects = [])
      subject = subject.class.find(subject.pid)
      assert_equal objects.count, subject.relationships(predicate).count
      objects.each do |object|
        internal_uri = object.respond_to?(:internal_uri) ?
          object.internal_uri : object
        assert subject.relationships(predicate).include?(internal_uri)
      end
    end

    def assert_active_fedora_belongs_to(subject, method_name, object)
      subject = subject.class.find(subject.pid)
      subject.send(method_name).must_equal object
    end

    def assert_active_fedora_has_many(subject, method_name, objects)
      subject = subject.class.find(subject.pid)
      association = subject.send(method_name)
      assert_equal objects.count, association.count
      objects.each do |object|
        assert association.include?(object)
      end
    end

    def with_persisted_area(name = nil, &block)
      options = {}
      options[:name] = name if name
      area = nil
      area = CommonRepositoryModel::Area.find_by_name(name) if name
      area ||= FactoryGirl.create(:common_repository_model_area, options)
      if block.arity == 1
        block.call(area)
      else
        block.call
      end
    ensure
      area.delete if area
    end
  end
end
require 'factory_girl'
['collection','area','data'].each do |name|
  begin
    require_relative "../../spec/factories/common_repository_model/#{name}_factory"
  rescue FactoryGirl::DuplicateDefinitionError
  end
end
