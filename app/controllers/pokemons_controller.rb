class PokemonsController < ApplicationController
  def capture
    @pokemon = Pokemon.find(params[:id])
    @pokemon.trainer_id = current_trainer[:id]
    @pokemon.save
    redirect_to root_path
  end

  def damage
  	@pokemon = Pokemon.find(params[:id])
  	@pokemon.health -= 10
  	if @pokemon.health <= 0
  	  @pokemon.destroy
  	else
  	  @pokemon.save
  	end
  	if not @pokemon.errors.full_messages.empty?
      flash[:error] = @pokemon.errors.full_messages.to_sentence
      redirect_to pokemons_new_path
    else
      redirect_to trainer_path(current_trainer[:id])
    end
  end

  def new
  end

  def create
    puts params[:pokemon][:name]
	  @pokemon = Pokemon.new({:name => params[:pokemon][:name], :trainer_id => current_trainer.id, :health => 100, :level => 1})
      @pokemon.save
    redirect_to trainer_path(current_trainer[:id])
  end

end