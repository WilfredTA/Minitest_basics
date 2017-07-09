# Below is a Todo class that represents a todo item and a collection class called TodoList
# that represents a collection of Todo object. TodoList can perform a lot of actions you'd 
# expect from a collection class. The current implementation of the TodoList uses an array
# as a storage mechanism, but it can be changed to any other mechanism or data structure in 
# the future without affecting any other code in our application -- only if collaborating 
# classes use the TodoList public interface (i.e. its public methods) rather than accessing
# any of its internal states (such as @todos array) directly.




class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

# The reason to create a custom to do list class rather
# than using a standard array is that Arrays possess unnecessary operations
# for a to do list and a to do list requires custom operations
# that the Array class does not offer; e.g., instead of having to mark
# an array or a hash with manual code, we can create a mark method for every
# to do list object

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def <<(todo)
    raise TypeError, 'can only add Todo objects' unless todo.instance_of? Todo

    @todos << todo
  end
  alias_method :add, :<<

  def item_at(idx)
    @todos.fetch(idx)
  end

  def mark_done_at(idx)
    item_at(idx).done!
  end

  def mark_undone_at(idx)
    item_at(idx).undone!
  end

  def done!
    @todos.each_index do |idx|
      mark_done_at(idx)
    end
  end

  def remove_at(idx)
    @todos.delete(item_at(idx))
  end

  def to_s
    text = "---- #{title} ----\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end

  def to_a
    @todos
  end

  def each
    counter = 0
    while counter < @todos.size
      yield(@todos[counter])
      counter += 1
    end
    self
  end

  def select
    counter = 0
    list = TodoList.new(title)
    each do |item|
      list.add(item) if yield(item)
    end
    list
  end

  def find_by_title(string)
    each do |todo|
      return todo if todo.title == string
      nil
    end
  end

  def all_done
    select do |todo|
      todo.done?
    end
  end

  def all_not_done
    select do |todo|
      !todo.done?
    end
  end

  def mark_done(title)
    each do |todo|
      todo.done! if todo.title == title
    end
  end

  def mark_all_done
    each do |todo|
      todo.done!
    end
  end

  def mark_all_undone
    each do |todo|
      todo.undone!
    end
  end

end

# The point of the custom #each method is encapsulation: True, we could just
# expose the internal state of the list by providing a getter method for @todos. However
# This allows users to interact with the internal state directly, rather than through the proxy
# of an interface that we have built. If we provide an interface for them, hiding the internal implementation
# we can always change the internal implementation and simply modify the interface, allowing the user experience
# to remain the same, and allowing any other classes that also need the method to remain the same, since
# those classes are also using the interface. 

  # Suppose later on we no longer want the internal representation to be an array (e.g. we want to change to a hash),
  # In that case, we would need a differnet mechanism to iterate over items in TodoList - it can't be Array#each anymore
  # because the internal state of the list is no longer an array. Internal to the TodoList class, all we have to do is change 
  # the TodoList#each. We need to figure out a new way to iterate over the new data strucutre. Users of the 
  # TodoList class shouldn't feel any change at all if they use TodoList#each. That method will still behave
  # the same to users (both humans and other classes) of the TodoList class; it will still iterate
  # through the items, yielding each Todo object at every iteration. However, if users of the TodoList class had instead reached
  # into the @todos variable directly (by way of using a getter method), then their code will break.

# Another example is the TodoList#add method: We would rather work with the TodoList#add method than to
# expose the array and allow them to modify the array of todos directly. Why? because our todolist add
# also implements a rule which prevents random objects from being added to the todolist and ensures that 
# only todo objects are being added. If we bypass the TodoList#add method by exposing @todos to the public
# interface, then we are no longer enforcing that rule. 

# The entire goal of creating a class and encapsulating logic in a class is to hide implementation details and contain ripple
# effects when things change. Prefer to use the clas

