require_relative '../test_helper'
require 'rails/all'
require_relative 'abstract_controller'
require_relative 'user'

describe Sync::Partial do
  include TestHelper

  before do
    @context = ActionController::Base.new
    @partial = Sync::Partial.new("show", User.new, nil, @context)
  end
 
  describe '#self.all' do
    it 'returns an array of all Partials for given model' do
      # TODO: Must configure Rails application for Rails.root
    end
  end

  describe '#render_to_string' do
    it 'renders itself as a string' do
      assert_equal "<h1>1<\/h1>", @partial.render_to_string
    end
  end
  
  describe '#render' do
    it 'renders' do
      # TODO stub out
      assert @partial.respond_to?(:render)
    end
  end

  describe '#sync' do
    it 'sends update to faye for given partial and update action' do
      # TODO stub out
      assert @partial.sync(:update)
    end

    it 'sends update to faye for given partial and destroy action' do
      # TODO stub out
      assert @partial.sync(:destroy)
    end
  end

  describe '#message' do
    it 'returns a Message instance for the partial for the update action' do
      assert_equal Sync.client.class::Message, @partial.message(:update).class
    end

     it 'returns a Message instance for the partial for the destroy action' do
      assert_equal Sync.client.class::Message, @partial.message(:destroy).class
    end
  end

  describe '#channel_id' do
    it 'returns a unique channel for the partial given its name and resource' do
      assert @partial.channel_id
    end
  end

  describe 'channel_for_action' do
    it 'returns the channel for the update action' do
      assert @partial.channel_for_action(:update)
    end

    it 'returns the channel for the destroy action' do
      assert @partial.channel_for_action(:destroy)
    end

    it 'always starts with a forward slash to provide Faye valid channel' do
      assert_equal "/", @partial.channel_for_action(:update).first
      assert_equal "/", @partial.channel_for_action(:destroy).first
    end
  end

  describe '#selector_start' do
    it 'returns a string for the selector to mark element beginning' do
      assert @partial.selector_start.present?
    end
  end

  describe '#selector_end' do
    it 'returns a string for the selector to mark element ending' do
      assert @partial.selector_end.present?
    end
  end
end
