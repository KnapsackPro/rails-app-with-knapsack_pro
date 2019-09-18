describe ArticlesController do
  describe '#index' do
    let(:articles) do
      [
        Article.create(title: 'Article 1'),
        Article.create(title: 'Article 2'),
      ]
    end

    before do
      expect(Article).to receive(:all).and_return(articles)

      get :index
    end

    it do
      expect(assigns(:articles)).to eq articles
    end

    it do
      expect(response).to be_success
    end
  end

  describe '#show' do
    before do
      get :index
    end

    it do
      expect(response).to be_success
    end
  end
end
