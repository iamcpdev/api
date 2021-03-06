# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::ChallengePost', type: :request do
  describe 'POST /v1/challenges/:id' do
    let(:challenge) { create(:challenge) }

    # override
    let(:headers) { {} }
    let(:params) { {} }

    before do
      post "/v1/challenges/#{challenge.id}/posts",
           headers: headers,
           params: params
    end

    it 'requires authentication' do
      expect(response.status).to eq(401)
    end

    context 'when authenticated' do
      let(:user) { create(:user_authed) }
      let(:headers) { { 'Authorization': "Bearer #{user.auth_token}" } }

      context 'with valid params' do
        let(:params) do
          {
            name: '90s Website',
            url: 'https://example.com',
            description: 'Win $50!'
          }
        end

        it 'succeeds' do
          expect(response.status).to eq(201)
          expect(json).to include(
            'id',
            'created_at',
            'updated_at',
            'name',
            'url',
            'url_redirect',
            'description',
            'creator',
            'click_count',
            'comment_count',
            'rank_score'
          )
          expect(json['creator']).to include(
            'id' => user.id,
            'username' => user.username
          )
          expect(json['creator']).to_not include('created_at', 'updated_at')
        end
      end

      context 'with invalid params' do
        let(:params) { {} } # deliberately left blank

        it 'fails gracefully' do
          expect(response.status).to eq(422)
          expect(json['errors']['name']).to include("can't be blank")
        end
      end
    end
  end

  describe 'GET /v1/challenges/:id/posts' do
    let(:challenge) { create(:challenge) }

    before do
      create_list(
        :challenge_post_with_upvotes,
        5,
        challenge: challenge,
        upvote_count: 5
      )
    end

    it 'returns all posts' do
      get "/v1/challenges/#{challenge.id}/posts"

      expect(response.status).to eq(200)
      expect(json.length).to eq(5)

      # includes list of upvotes
      expect(json[0]['upvotes'].length).to eq(5)
      expect(json[0]['upvotes'][0]).to include(
        'id',
        'created_at',
        'updated_at'
      )
      expect(json[0]['upvotes'][0]['user']).to include(
        'id',
        'username'
      )
      expect(json[0]['upvotes'][0]).to_not include('challenge_post_id')
      expect(json[0]['upvotes'][0]['user']).to_not include('email')
    end

    context 'with shadowbanned votes' do
      let(:user) do
        u = create(:user_authed)
        u.shadow_ban!
        u.save

        u
      end

      before do
        ChallengePost.find_each do |post|
          create(
            :challenge_post_upvote,
            challenge_post: post,
            user: user
          )
        end
      end

      it 'does not include shadowbanned upvotes' do
        get "/v1/challenges/#{challenge.id}/posts"

        expect(json[0]['upvotes'].length).to eq(5)
      end

      context 'and authenticated as shadowbanned user' do
        let(:headers) { { "Authorization": "Bearer #{user.auth_token}" } }

        it 'includes shadowbanned upvotes' do
          get "/v1/challenges/#{challenge.id}/posts", headers: headers

          expect(json[0]['upvotes'].length).to eq(6)
        end
      end

      context 'and authenticated as post creator' do
        let(:user) do
          u = ChallengePost.first.creator
          u.generate_auth_token!
          u.save

          u
        end

        let(:headers) { { "Authorization": "Bearer #{user.auth_token}" } }

        it 'includes shadowbanned upvotes' do
          get "/v1/challenges/#{challenge.id}/posts", headers: headers

          expect(json[0]['upvotes'].length).to eq(6)
        end
      end
    end
  end
end
