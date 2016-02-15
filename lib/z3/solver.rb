class Z3::Solver
  def initialize
    @_solver = Z3::Core.Z3_mk_solver(Z3::Context._context)
  end

  def push
    Z3::Core.Z3_solver_push(Z3::Context._context, @_solver)
  end

  def pop(n=1)
    Z3::Core.Z3_solver_pop(Z3::Context._context, @_solver, n)
  end

  def reset
    Z3::Core.Z3_solver_reset(Z3::Context._context, @_solver)
  end

  def assert(ast)
    Z3::Core.Z3_solver_assert(Z3::Context._context, @_solver, ast._ast)
  end

  def check
    check_sat_results(Z3::Core.Z3_solver_check(Z3::Context._context, @_solver))
  end

  def model
    Z3::Model.new(
      Z3::Core.Z3_solver_get_model(Z3::Context._context, @_solver)
    )
  end

  def prove!(ast)
    push
    assert(~ast)
    case check
    when :sat
      puts "Counterexample exists"
    when :unknown
      puts "Unknown"
    when :unsat
      puts "Proven"
    else
      raise "Wrong SAT result #{r}"
    end
  ensure
    pop
  end

  private

  def check_sat_results(r)
    case r
    when 1
      :sat
    when 0
      :unknown
    when -1
      :unsat
    else
      raise "Wrong SAT result #{r}"
    end
  end
end
