describe 'Bar', :tag_a do
  it 'Bar 1' do
    expect(Article.new).to be_kind_of Article
  end

  it 'Bar 2 - tag_x', :tag_x do
  end

  it 'Bar 3 - tag_x', :tag_x do
  end

  it 'Bar 4 - tag_x AND tag_y', :tag_x, :tag_y do

  end
end
