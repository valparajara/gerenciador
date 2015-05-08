require "rails_helper"

feature "As a user registered, i want create a question" do
  let!(:user) { create :user }

  puts :user

  def sign_in(user, password=nil)
    visit root_path

    fill_in 'Email', with: user.email
    fill_in 'Senha', with: password || user.password

    click_button "Entrar"
  end

  context "Given I'm on page login" do
    scenario "when I digit an e-mail and password valid, then I log successfully" do
      sign_in(user)

      have_title "Listas de questões"
    end

    scenario "when I digit e-mail or password invalid, then I see the error" do
      sign_in(user, 'asd')

      expect(page).to have_content "E-mail ou senha inválidos."
    end
  end

  context "Given I'm on the questions list" do

    scenario "when I click on 'Criar questão', then the question form is displayed" do
      sign_in(user)

      click_on "Criar questão"
      have_title "Criar nova questão"
    end
  end

  context "Given I'm on the question form" do
    scenario "when I fill fields all, and I click on  Criar Questão', then the question should registered and I see the question" do
      sign_in(user)
      visit new_question_path

      fill_in 'Código', with: '001'
      fill_in 'Enunciado', with: 'Questão 01'
      fill_in 'Gabarito', with: 'A'

      within_fieldset('Alternativas') do
        alternativas = ('A'..'E').to_a

        all('.form-group').each_with_index do |fg, index|
          within(fg) do
            expect(page).to have_field('Alternativa', with: alternativas[index])

            fill_in 'Resposta', with: "Alternativa #{alternativas[index]}"
          end
        end
      end
      click_button "Criar Questão"
      expect(page).to have_content("Questão criada com sucesso.")
    end

    scenario "When I not fill one requerid field, and I click on 'Criar Questão', then the question not should registered and I see the error" do
      sign_in(user)
      visit new_question_path

      fill_in 'Código', with: '001'
      fill_in 'Enunciado', with: ''
      fill_in 'Gabarito', with: 'A'

      within_fieldset('Alternativas') do
        alternativas = ('A'..'E').to_a

        all('.form-group').each_with_index do |fg, index|
          within(fg) do
            expect(page).to have_field('Alternativa', with: alternativas[index])

            fill_in 'Resposta', with: "Alternativa #{alternativas[index]}"
          end
        end
      end
      click_button "Criar Questão"
      expect(page).to have_content("Enunciado não pode ficar em branco")
    end

    scenario "when I not fill a response the alternative and I click on 'Criar Questão', then the question not should registered and I see the error" do
      sign_in(user)
      visit new_question_path

      fill_in 'Código', with: '001'
      fill_in 'Enunciado', with: 'Questão 01'
      fill_in 'Gabarito', with: 'A'

      within_fieldset('Alternativas') do
        alternativas = ('A'..'E').to_a

        all('.form-group').each_with_index do |fg, index|
          within(fg) do
            expect(page).to have_field('Alternativa', with: alternativas[index])

            fill_in 'Resposta', with: index % 2 == 0 ? "Alternativa #{alternativas[index]}" : ''
          end
        end
      end
      click_button "Criar Questão"
      expect(page).to have_content("Resposta das alternativas não pode ficar em branco")
    end
  end
end
