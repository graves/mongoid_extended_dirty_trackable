require 'mongoid'
require 'active_support/concern'

module Mongoid
  module ExtendedDirtyTrackable
    extend ActiveSupport::Concern

    included do
      attr_writer :embedded_changes, :associated_changes
    end

    def associated_changes
      @associated_changes = begin
        self.associations.keys.inject({}) do |memo, association|
          _changes = msg_relative(association)
          memo.merge!(_changes)
          memo
        end
      end
    end

    def msg_relative(relationship)
      relative = self.send(relationship)

      if relative && !relative.is_a?(Array) && relative.changed?
        _changes = relative.changes
      elsif relative && relative.is_a?(Array) && relative.any?(&:changed)
        _changes = relative.inject({}) do |memo, obj|
          memo.merge!(obj.changes) if obj.changed?
        end
      end

      _changes || {}
    end

    def embedded_changes
      @embedded_changes = begin
        self.collect_children.inject({}) do |memo, child|
          memo.merge!(child.changes) if child.changed?
          memo
        end
      end
    end

    def changes
      from_super = super
      from_super.merge!(associated_changes)
      from_super.merge!(embedded_changes)
    end

    def changed?
      super || self._children.any?(&:changed?)
    end
  end
end
