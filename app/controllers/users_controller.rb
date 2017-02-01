class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  require 'net/ldap'
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end
 
  
  def find_user
      results = @ldap_ind.search( :base => "dc=lister,dc=lan", :filter => user_filter)
      return results.first
  end

  
  def user_filter
      search_param = params[:username]
      search_filter = Net::LDAP::Filter.eq("sAMAccountName", search_param)
      group_filter = Net::LDAP::Filter.eq("objectClass", "user")
      composite_filter = Net::LDAP::Filter.join(search_filter, group_filter)
      composite_filter
    end  
   

  def search

    if params[:username] != 'root'
      search_param = params[:username]
      result_attrs = ["sAMAccountName", "displayName", "mail"]
      search_filter = Net::LDAP::Filter.eq("sAMAccountName", search_param)
      # search_filter = Net::LDAP::Filter.eq("mail", search_param)
      group_filter = Net::LDAP::Filter.eq("objectClass", "user")
      composite_filter = Net::LDAP::Filter.join(search_filter, group_filter)
      host = ENV['LDAPHOST']
      @ldap_ind = Net::LDAP.new  :host => ENV['LDAPHOST'], # your LDAP host name or IP goes here,
      :port => ENV['LDAPPORT'] # your LDAP host port goes here,
      @ldap_ind.authenticate(ENV['LDAPUSER'], ENV['LDAPPWD'])
      bindresult = @ldap_ind.bind_as(:base => ENV['LDAPBASE'], :password =>params[:password], :filter => composite_filter)
      arr = []
      if bindresult
          entry = find_user
          if entry
            ldap = Net::LDAP.new  :host => ENV['LDAPHOST'], # your LDAP host name or IP goes here,
            :port => ENV['LDAPPORT'] , # your LDAP host port goes here,
            # :encryption => :simple_tls,
            :base => ENV['LDAPBASE'] , # the base of your AD tree goes here,
            :auth => {
              :method => :simple,
              :username => ENV['LDAPUSER'], # a user w/sufficient privileges to read from AD goes here,
              :password => ENV['LDAPPWD'] # the user's password goes here
            }
            if ldap.bind
              item = ldap.search(:filter => composite_filter, :attributes => result_attrs, :return_result => true).first
              sAMAccountName = item.sAMAccountName.first
              mail = item.mail.first
              displayName = item.displayName.first
              access_token = SecureRandom.hex
              ApiKey.create({access_token: access_token})
              if mail
                resource=Resource.find_by_mail(mail.downcase)
                if resource
                  resource_id = resource.id
                  employee_id = resource.employee_id
                  role = Role.find(resource.heirarchy_id)
                  respond_to do |format|
                   result = {username: sAMAccountName, employee_id: employee_id,resource_id: resource_id, role: role.heirarchy_id,created_at: resource.created_at ,updated_at: resource.updated_at,mail: resource.mail}
                   format.json { render json: {user: result,access_token: access_token } }
                  end
                else
                  resource_id = 0
                  employee_id = "admin"
                  respond_to do |format|
                   format.json { render json: {user: {error: "Please Check with your Manager"} } }
                  end
                end
              else
                employee_id = "admin"
                resource_id = 0
                respond_to do |format|
                   format.json { render json: {user: {error: "Please Check with your Manager"} } }
                end
              end 
                # respond_to do |format|
                #  result = {username: sAMAccountName, employee_id: employee_id,resource_id: resource_id, role: resource.heirarchy_id,created_at: resource.created_at ,updated_at: resource.updated_at,mail: resource.mail}
                #  format.json { render json: {user: result,access_token: access_token } }
                # end
             end
          end
            
      else
        respond_to do |format|
         format.json { render json: {user: {error: "Wrong Credentials"} } }
        end
      end
    else 
          user = User.authenticate(params[:username], params[:password])
          if user
            access_token = SecureRandom.hex
            ApiKey.create({access_token: access_token})
            resource_id = 0
            employee_id = "admin"
            respond_to do |format|
              result = {username: params[:username], employee_id: employee_id,resource_id: resource_id, role: 0 ,created_at:  user.created_at,updated_at: user.updated_at,mail: 'root@example.com'}
              format.json { render json: {user: result,access_token: access_token } }
            end 
          else
             respond_to do |format|
               format.json { render json: {user: {error: "No User Present"} } }
              end
          end
          
    end
  end

  
  def create
    @user = User.new()
    @user.username = user_params[:username]
    @user.password = user_params[:password]
    @user.employee_id = user_params[:employee_id]
    res = Resource.find_by_employee_id(user_params[:employee_id])
    if res
     role = Role.find(res[:heirarchy_id])
    end
    if role
      if role[:heirarchy_id] == 1 
        @user.role = "pm"
      elsif role[:heirarchy_id] == 2 
        @user.role = "pl"
      end
    else
      @user.role = ""
    end
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: {success: @user } }
      else
        format.html { render :new }
        format.json { render json: {error: @user.errors }}
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :role, :employee_id)
    end
end
