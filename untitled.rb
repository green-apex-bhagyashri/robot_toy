class Api::OrdersController < ApplicationController
	def order
		@curr_pos = get_current_pos(params[:command])
		if @curr_pos 
			@last_pos = @curr_pos
			params[:command].drop(1).each do |cmd|
				send(cmd.downcase)
			end

			if @last_pos.save
				render json: {return_output(@last_pos)}
			else
				render json: {return_output(@last_pos.errors)}
			end
		end

	end

	private
	def get_current_pos(command) 
		Order.new(x_pos:get_x_pos(command[0]),
				y_pos: get_y_pos(command[1]),
				get_facing(command[2]))
	end

	def get_x_pos(arr)
		arr.split("PLACE")[1].split(",")[0].to_i
	end
	def get_y_pos(arr)
		arr.split("PLACE")[1].split(",")[1].to_i
	end
	def facing(arr)
		arr.split("PLACE")[1].split(",")[2].strip
	end

	def move
		case @last_pos.facing
		when "NORTH"
			@last_pos.facing +=1
		when "SOUTH"
			@last_pos.facing -=1
		when "EAST"
			@last_pos.facing +=1
		when "WEST"
			@last_pos.facing -=1
		end
	end

	def left
		case @last_pos.facing
		when "NORTH"
			@last_pos.facing = "WEST"
		when "SOUTH"
			@last_pos.facing = "EAST"
		when "EAST"
			@last_pos.facing = "NORTH"
		when "WEST"
			@last_pos.facing = "SOUTH"
		end
	end

	def right

		case @last_pos.facing
		when "NORTH"
			@last_pos.facing = "EAST"
		when "SOUTH"
			@last_pos.facing = "WEST"
		when "EAST"
			@last_pos.facing = "SOUTH"
		when "WEST"
			@last_pos.facing = "NORTH"
		end
	end

	def report
	end

	def return_output(order)
		{
			location: [order.x_pos,order.y_pos, order.facing]
		}
	end
end