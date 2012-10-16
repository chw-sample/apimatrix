class Message
  
  extend AttributeReader
  
  attributes :id, :destination, :content, :direction, :favorite, :read_status, :source, :type, :upload_date
  
  def initialize(result)
    @result = result
  end
  
  private
  
  def to_hash
    @result
  end
  
end