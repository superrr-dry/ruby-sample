class TestsController < ApplicationController
    before_action :set_test, only: %i[edit update destroy]
    def index
        @tests = Test.all
    end

    def new
        @test = Test.new
    end

    def create
        @test = Test.new(test_params)
        if @test.save
            redirect_to tests_path and return
        end

        flash[:errors] = @test.errors.full_messages
        redirect_to action: :new
    end

    def edit
    end

    def update
        if not @test.update(test_params)
            flash[:errors] = @test.errors.full_messages
        end
        redirect_to action: :edit
    end

    def destroy
      @test.destroy
      redirect_to tests_path
    end

    private
    def set_test
        @test = Test.find(params[:id])
    end
    # ストロングパラメータ
    # permitで指定した項目を許可する
    def test_params
        params.require(:test).permit(:user_id, :content)
    end
end
