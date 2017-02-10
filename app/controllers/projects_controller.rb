class ProjectsController < ApplicationController
before_action :find_project, only: [:show, :edit, :update, :destroy]
before_action :require_admin, only: [:create,:edit, :update, :destroy]


    
    def index
 @projects = Project.all.order("created_at DESC")
    end

    def show
     
    end

    def new
@project= current_user.projects.build
    end


    def create
@project= current_user.projects.build(project_params)

if @project.save
    redirect_to @project, notice: "Le projet a ete cree"
    else 
        render 'new'
    end
    end


    def edit
    end

    def update
        if @project.update(project_params)
            redirect_to @project
            else
                render 'edit'
        end
    end

    def destroy
    end

private

def find_project
       @project= Project.find(params[:id])  
end

def project_params
    params.require(:project).permit(:name, :description,:amount ,:image)

end

def require_admin
if !current_user.admin?

flash[:danger] = "Only admin users can perform that action"


    redirect_to projects_path
end
end
    
end
