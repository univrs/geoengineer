########################################################################
# TerraformCommands provides command line terraform commands
# +plan+ and +apply+ for GeoEngineer
########################################################################
module GeoCLI::TerraformCommands
  def create_terraform_files
    # create terraform file
    File.open("#{@tmpdir}/#{@terraform_file}", 'w') { |file|
      file.write(JSON.pretty_generate(@environment.to_terraform_json()))
    }

    # create terrafrom state
    File.open("#{@tmpdir}/#{@terraform_state_file}", 'w') { |file|
      file.write(JSON.pretty_generate(@environment.to_terraform_state()))
    }
  end

  def terraform_plan
    plan_commands = [
      "cd #{@tmpdir}",
      "terraform plan -state=#{@terraform_state_file} -out=#{@plan_file} #{@no_color}"
    ]
    shell_exec(plan_commands.join(" && "), true)
  end

  def terraform_apply
    apply_commands = [
      "cd #{@tmpdir}",
      "terraform apply -state=#{@terraform_state_file} #{@plan_file} #{@no_color}"
    ]
    shell_exec(apply_commands.join(" && "), true)
  end

  def plan_cmd
    command :plan do |c|
      c.syntax = 'geo plan [<geo_files>]'
      c.description = 'Generate and show an execution plan'
      action = lambda do |args, options|
        create_terraform_files
        terraform_plan
      end
      c.action init_action(:plan, &action)
    end
  end

  def apply_cmd
    command :apply do |c|
      c.syntax = 'geo apply [<geo_files>]'
      c.description = 'Apply an execution plan'
      action = lambda do |args, options|
        create_terraform_files
        return puts "Plan Broken" if terraform_plan.exitstatus.nonzero?
        return puts "Rejecting Plan" unless yes?("Apply the above plan? [YES/NO]")
        terraform_apply
      end
      c.action init_action(:apply, &action)
    end
  end
end
