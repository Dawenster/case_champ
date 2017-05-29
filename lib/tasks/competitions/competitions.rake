namespace :competitions do
  desc "Import initial competitions"
  task import_initial_competitions: :environment do
    require 'open-uri'

    CSV.foreach("db/csvs/competitions.csv") do |row|
      begin
        competition_name          = row[0] || "Dummy data"

        event_name                = row[1] || "Dummy data"
        
        source_url                = row[2] || "https://upload.wikimedia.org/wikipedia/en/thumb/9/96/Kellogg_School_of_Management.svg/1280px-Kellogg_School_of_Management.svg.png"
        cloudinary_object         = Cloudinary::Uploader.upload(source_url)
        image_url                 = cloudinary_object['public_id']
        sponsor                   = row[3] || "Dummy data"

        category                  = row[4] || "Dummy data"

        description               = row[5] || "Dummy data"
        city                      = row[6] || "Dummy data"
        state_and_country         = row[7] || "Dummy data"

        prize_1_text              = row[8] || "Dummy data"
        prize_2_text              = row[9]
        prize_3_text              = row[10]

        min_team_size             = row[11]
        max_team_size             = row[12]
        num_kellogg_teams_allowed = row[13]

        milestone_1_text          = row[14] || "Dummy data"
        milestone_1_date          = row[15] || Time.current
        milestone_2_text          = row[16]
        milestone_2_date          = row[17]
        milestone_3_text          = row[18]
        milestone_3_date          = row[19]

        logistics                 = row[20]
        application               = row[21]
        application_url           = row[22] || "https://www.dummydata.com"
        contact_name              = row[23] || "Dummy data"
        position_and_organization = row[24] || "Dummy data"
        contact_email             = row[25] || "dummy@data.com"
        contact_phone             = row[26]

        competition = Competition.create!(
          name:     competition_name,
          category: category
        )

        event = Event.new(
          competition_id: competition.id,
          name: 2017,
          sponsor: sponsor,
          description: description,
          city: city,
          state_and_country: state_and_country,
          min_team_size: min_team_size,
          max_team_size: max_team_size,
          num_kellogg_teams_allowed: num_kellogg_teams_allowed,
          logistics: logistics,
          application: application,
          application_url: application_url,
          contact_name: contact_name,
          position_and_organization: position_and_organization,
          contact_email: contact_email,
          contact_phone: contact_phone,
          image_url: image_url
        )
        event.published = true
        event.save(validate: false)

        event.prizes << Prize.create!(
          rank: 1,
          description: prize_1_text
        )

        if prize_2_text.present?
          event.prizes << Prize.create!(
            rank: 2,
            description: prize_2_text
          )
        end

        if prize_3_text.present?
          event.prizes << Prize.create!(
            rank: 3,
            description: prize_3_text
          )
        end

        event.milestones << Milestone.create!(
          description: milestone_1_text,
          deadline_at: milestone_1_date
        )

        if milestone_2_text.present?
          event.milestones << Milestone.create!(
            description: milestone_2_text,
            deadline_at: milestone_2_date
          )
        end

        if milestone_3_text.present?
          event.milestones << Milestone.create!(
            description: milestone_3_text,
            deadline_at: milestone_3_date
          )
        end
      rescue
        puts row
      end
    end
  end
end
