shared_examples_for 'Many Files' do

  it 'have many attached files' do
    expect(files).to be_an_instance_of(ActiveStorage::Attached::Many)
  end
end