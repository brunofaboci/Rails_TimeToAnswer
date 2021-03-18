namespace :dev do

  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp') #
  desc "Cria os usuários padrão"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Drop...") { %x(rails db:drop) }
      show_spinner("Create...") { %x(rails db:create) }
      show_spinner("Migrate...") { %x(rails db:migrate) }
      show_spinner("Create Admin...") { %x(rails dev:add_default_admin) }
      show_spinner("Create Others Admins...") { %x(rails dev:add_extra_admin) }
      show_spinner("Create User...") { %x(rails dev:add_default_user) }
      show_spinner("Create Default Subjects...") { %x(rails dev:add_subjects) }
      show_spinner("Create Default Questions/Answers...") { %x(rails dev:add_questions_and_answers) } 
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end

  desc "Adiciona o administrados padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'brunofaboci@gmail.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona mais Admnistradores"
  task add_extra_admin: :environment do
    10.times do |i|
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end
  end

  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do
    User.create!(
      email: 'brunofaboci@gmail.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona Assuntos Padrão"
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
    end
  end

  desc "Adiciona perguntas e respostas"
  task add_questions_and_answers: :environment do
    Subject.all.each do |subject|
      rand(5..10).times do |i|
        params = create_question_params(subject)
        answers_array = params[:question][:answers_attributes]

        add_answers(answers_array)
        elect_true_answer(answers_array)

        Question.create!(params[:question])
      end
    end
  end

  desc "Reset questions_count"
  task reset_questions_count: :environment do
    show_spinner("Reseting questions count...") do
      Subject.find_each do |subject|
        Subject.reset_counters(subject.id, :questions)
      end
    end
  end

  private

  def create_question_params(subject = Subject.all.sample)
    { question: {
        description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
        subject: subject,
        answers_attributes: []
      }
    }
  end

  def create_answer_params(correct = false)
    { description: Faker::Lorem.sentence, correct: correct }
  end
  
  def add_answers(answers_array = [])
    rand(2..5).times do |j|
      answers_array.push(create_answer_params)
    end
  end

  def elect_true_answer(answers_array = [])
    selected_index = rand(answers_array.size)
    answers_array[selected_index] = create_answer_params(true)
  end
  
  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end

end
