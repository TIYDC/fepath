require 'active_support/inflector'

class Gid
  attr_reader :gid
  def initialize(gid)
    @gid = gid
  end

  def path(action: nil)
    [klass.downcase.pluralize, id, action].compact.join('/')
  end

  def id
    components.last
  end

  def klass
    components.first
  end

  def to_param
    { "#{klass.downcase}[id]" => id }
  end

  private

  def components
    gid.split('/', 4).last.split('/')
  end
end
