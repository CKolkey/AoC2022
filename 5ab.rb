class CraneMover
  attr_reader :stacks, :instructions

  def initialize(stacks, instructions)
    @stacks       = build_stacks stacks
    @instructions = parse_instructions instructions
  end

  def operate!
    instructions.each { perform_instruction!(*_1) }
  end

  def results
    stacks.values.map(&:first).join
  end

  private

  def parse_instructions(instructions)
    instructions.lines.map { _1.scan(/\d+/).map(&:to_i) }
  end

  def build_stacks(stacks)
    stacks.lines[..-2]
          .map { _1.scan(/(\w|\s{4})/).flatten }
          .transpose
          .map { _1.grep(/\w/) }
          .map.with_index(1) { [_2, _1] }
          .to_h
  end
end

class CraneMover9000 < CraneMover
  def perform_instruction!(quantity, from, to)
    quantity.times { stacks[to].unshift(stacks[from].shift) }
  end
end

class CraneMover9001 < CraneMover
  def perform_instruction!(quantity, from, to)
    stacks[to].unshift(stacks[from].shift(quantity)).flatten!
  end
end

input = File.read("5.input").split("\n\n")

cm9k = CraneMover9000.new(*input)
cm9k.operate!
puts cm9k.results # == "SPFMVDTZT"

cm9k1 = CraneMover9001.new(*input)
cm9k1.operate!
puts cm9k1.results # == "ZFSJBPRFP"
