class Buffer
	Cell = Struct.new(:data, :next)
	def initialize
		@tail = @cur = Cell.new('EOF', nil)
		@head = @prev = Cell.new('', @cur)
	end

	def ateof
		@cur == @tail
	end

	def top
		@prev = @head; @cur = @head.next
	end

	def forward
	    return if ateof
		@prev = @cur; @cur = @cur.next
	end
	def backward
		if(@prev == @head) then; return; end;
		tmp = @prev;
		self.top();
		while(@cur != tmp) do
			self.forward();
		end
	end

	def swap
		if ateof then; return; end;
		if @cur.next == @tail then; return; end;
		tmp = @cur.next.next;
		@prev.next = @cur.next;
		@cur.next.next = @cur;
		@cur.next = tmp;
		@cur = @prev.next;
		#@cur = @prev.next;
	end
	def reverse
		self.top
		tail = @head;
		tail.next = nil;
		pre = tail;
		cur = @cur;
		while(cur != @tail)
			curNext = cur.next
			cur.next = pre;
			pre = cur;
			cur = curNext;
		end
		cur.next = pre;
		@head = cur;
		@tail = tail;
	end

	def insert(s)
    	@prev.next = Cell.new(s, @cur); @prev = @prev.next;
	end

	def delete
    	if ateof then; return; end;
	    @prev.next = @cur.next; @cur = @cur.next;
	end

	def print
    	puts(' ' + @cur.data);
  	end
end

buffer = Buffer.new;
buffer.insert('hello');
buffer.insert('my');
buffer.insert('world');
buffer.insert('!!!');
buffer.top;
buffer.print;
buffer.forward;
buffer.delete;
buffer.print
buffer.forward
buffer.print
buffer.forward
buffer.print

buffer = Buffer.new;
buffer.insert('hello');
buffer.insert('my');
buffer.insert('world');
buffer.insert('!!!');
buffer.top;
buffer.print;
buffer.forward;
buffer.swap();
buffer.print
buffer.forward
buffer.print
buffer.forward
buffer.print

buffer = Buffer.new;
buffer.insert('hello');
buffer.insert('my');
buffer.insert('world');
buffer.insert('!!!');
buffer.top;
buffer.print;
buffer.forward;
buffer.print
buffer.backward;
buffer.print
buffer.forward
buffer.print

buffer = Buffer.new;
buffer.insert('hello');
buffer.insert('my');
buffer.insert('world');
buffer.insert('!!!');
buffer.reverse;
buffer.top;
buffer.print;
buffer.forward;
buffer.print
buffer.forward
buffer.print
buffer.forward
buffer.print