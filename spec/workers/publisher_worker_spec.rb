require 'rails_helper'
Sidekiq::Testing.fake!

RSpec.describe PublisherWorker, type: :worker do
  describe 'Sidekiq Worker' do
    
    let(:post) { create :post }

    it 'should respond to #perform' do
      expect(PublisherWorker.new).to respond_to(:perform)
    end

    describe 'Publisher' do
      it 'enqueue a job' do
        expect { 
          PublisherWorker.perform_async post.id
        }.to change(PublisherWorker.jobs, :size).by 1
      end

      it 'enqueue a job at defined time' do
        expect { 
          PublisherWorker.perform_at post.publish_at, post.id
        }.to change(PublisherWorker.jobs, :size).by 1
      end
    end

  end
end
