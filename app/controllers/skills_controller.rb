class SkillsController
  def initialize(origin_training_path)
    @origin_training_path = origin_training_path
  end

  def add
    puts "What #{@origin_training_path.name} skill do you want to add?"
    name = clean_gets
    skill = Skill.create(name: name, training_path: @origin_training_path)
    if skill.new_record?
      puts skill.errors
    else
      puts "#{name} has been added to the #{@origin_training_path.name} training path"
    end
  end

  def view(skill_number)
    skill = @origin_training_path.skills[skill_number -1]
    puts "=============="
    puts "#{skill.name}"
    puts skill.description.nil? ? "Enter 'describe' to add a description." : skill.description
    puts "Enter describe or master to continue."
    puts "=============="
    command = clean_gets
    case command
    when "describe"
      describe(skill)
    when "master"
      puts "Would you like to become a master in this skill (y/n)"
      master(skill)
    end
  end

  def master(skill)
    choice = clean_gets
    skill.set_mastery(choice)
  end

  def describe(skill)
    description = clean_gets
    skill.set_description(description)
  end

  def list
    puts "=============="
    puts "#{@origin_training_path.name.upcase} SKILLS"
    puts "=============="
    @origin_training_path.skills.each_with_index do |skill, index|
      output = "#{index + 1}. #{skill.name}"
      output << " \u2713" if skill.mastered == 'true'
      puts output
    end
    Router.navigate_skills_menu(self)
  end
end
