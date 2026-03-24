# frozen_string_literal: true

module HashMap
  # linked list for use in buckets
  class LinkedList
    attr_accessor :start

    def initialize
      @start = nil
    end

    def append(key: nil, value: nil)
      new_node = Node.new(key: key, value: value)
      send(append_methods, new_node)
    end

    def update(key: nil, value: nil)
      node = match_key_node(node: start, key: key)
      node.value = value unless node.nil?
    end

    def find(key: nil)
      match_key_value(node: start, key: key)
    end

    def remove(key: nil)
      return nil if empty?

      value = remove_first_node(key: key)
      return value unless value.nil?

      parent_node, delete_node = remove_node(parent_node: start,
                                             child_node: start.child,
                                             key: key)

      value = delete_node.value
      parent_node.child = delete_node.child
      value
    end

    def to_a
      to_array(start)
    end

    def empty?
      return true if start.nil?

      false
    end

    private

    def to_array(node)
      return [] if node.nil?
      return [[node.key, node.value]] if node.child.nil?

      nodes = to_array(node.child)
      nodes << [node.key, node.value]

      nodes
    end

    def remove_first_node(key: nil)
      if start.key == key
        value = start.value
        self.start = start.child
        return value
      end
      nil
    end

    def remove_node(parent_node: nil, child_node: nil, key: nil)
      return nil if child_node.nil?
      return [parent_node, child_node] if child_node.key == key

      parent_node = node.child
      child_node = parent_node.child
      remove_node(parent_node: parent_node, current_node: child_node, key: key)
    end

    def match_key_value(node: nil, key: nil)
      return nil if node.nil?
      return node.value if node.key == key
      return nil if node.child.nil?

      match_key_value(node: node.child, key: key)
    end

    def match_key_node(node: nil, key: nil)
      return nil if node.nil?
      return node if node.key == key
      return nil if node.child.nil?

      match_key_node(node: node.child, key: key)
    end

    def append_methods
      return :append_initial_node if start.nil?

      :append_next_node
    end

    def append_initial_node(new_node)
      self.start = new_node
      start.child = nil

      nil
    end

    def append_next_node(new_node)
      new_node.child = nil
      last_node(start).child = new_node
      nil
    end

    def last_node(node)
      return node if node.child.nil?

      last_node(node.child)
    end
  end

  # node for the linked list
  class Node
    attr_accessor :child, :key, :value

    def initialize(key: nil, value: nil, child: nil)
      @key = key
      @value = value
      @child = child
    end
  end
end
