class MethodPerformer
  @queue = :default
  
  def self.perform(class_name, instance_id, method)
    class_name.constantize.find(instance_id).send(method)
  end
  
  def self.perform_later(instance, method)
    Resque.enqueue(MethodPerformer, instance.class.name, instance.id, method)
  end
  
end
