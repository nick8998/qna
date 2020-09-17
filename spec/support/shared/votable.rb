shared_examples_for 'Votable' do
   it { should have_many(:votes).dependent(:destroy)}
end