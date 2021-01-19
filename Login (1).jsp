<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>

<% 

		String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
		String DB_URL="jdbc:mysql://localhost/Information";

		//  Database credentials
		String USER = "root";
		String PASS = "rajagiri";

		// Set response content type
		response.setContentType("text/html");

		int flag=0;
		Statement stmt= null;
		String sql=null;
		Connection conn=null;
		try
		{
			// Register JDBC driver
			Class.forName("com.mysql.jdbc.Driver");

			// Open a connection
			conn = DriverManager.getConnection(DB_URL, USER, PASS);

			// Execute SQL query
			stmt = conn.createStatement();
   
			sql = "SELECT * FROM User";
			ResultSet rs = stmt.executeQuery(sql);
			String name = request.getParameter("userName");
			String pass = request.getParameter("password");
			// Extract data from result set; Retrieve by column name
			while(rs.next())
			{
				String uname = rs.getString("Username");
				String passw = rs.getString("Password");
				if ( name.equals(uname) && pass.equals(passw) )
				{
					flag=1;
					RequestDispatcher rd = request.getRequestDispatcher("/cp.html");
					rd.include(request,response);
					
				}
			}
			if(flag==0)
			{
				RequestDispatcher rd = request.getRequestDispatcher("/register.html");
				rd.include(request,response);
			}
			rs.close();
			stmt.close();
			conn.close();
		}
		catch(SQLException se)
		{
			//Handle errors for JDBC
			se.printStackTrace();
		}
		catch(Exception e)
		{
			//Handle errors for Class.forName
			e.printStackTrace();
		}
		finally
		{
			//finally block used to close resources
			try
			{
				if(stmt!=null)
				stmt.close();
			}
			catch(SQLException se2)
			{
			} // nothing we can do
			try
			{
				if(conn!=null)
				conn.close();
			}
			catch(SQLException se)
			{
				se.printStackTrace();
			} //end finally try
		} //end try
%>