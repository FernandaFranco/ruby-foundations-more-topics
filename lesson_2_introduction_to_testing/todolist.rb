# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

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

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  # rest of class needs implementation
  def add(chore)
    raise TypeError, 'can only add Todo objects' unless chore.instance_of? Todo

    @todos << chore
  end
  alias_method :<<, :add

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def item_at(index)
    @todos.fetch(index)
  end

  def mark_done_at(index)
    item_at(index).done!
  end

  def mark_undone_at(index)
    item_at(index).undone!
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    p @todos.delete(item_at(index))
  end

  def to_s
    text = "---- #{title} ----\n"
    text << @todos.map(&:to_s).join("\n")
    text  end

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

  # def select
  #   @todos.select { |todo| yield(todo)}
  # end

  def select
    selected_list = TodoList.new(title)
    each do |todo|
      selected_list << todo if yield(todo)
    end

    selected_list
  end

  def find_by_title(string)
    select { |todo| todo.title == string }.first
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(string)
    find_by_title(string) && find_by_title(string).done!
  end

  def mark_all_done
    each { |todo| todo.done! }
  end
  alias_method :done!, :mark_all_done

  def mark_all_undone
    each { |todo| todo.undone! }
  end

  def ==(other_todolist)
    self.to_a == other_todolist.to_a
  end


  def done?
    self == all_done
  end

end
