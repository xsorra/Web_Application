<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrar Intranet</title>
    </head>
    <body>
        <h1>Registrar Intranet</h1>
        
        <%
            try
            {    
                //connecting to MySQL database called students
                String database = "jdbc:mysql://localhost:3306/students";
                String user = "root";
                String password = "root";
            
                Class.forName("com.mysql.jdbc.Driver");
            
                //creating a Connection object
                Connection myconn= DriverManager.getConnection(database,user,password);
            
                //reading the value of the submit button
                String buttonvalue = request.getParameter("submitB");
            
                //reading the ID from form
                int inputID = Integer.parseInt(request.getParameter("idTxtBx"));
                
                //checking if student is in the database
                String SQLselect = "select * from students where ID=" + inputID;
                
                boolean foundstudent = false;
            
                //creating a Statement object
                Statement mystat = myconn.createStatement();
                
                //running SQLselect with the statement
                //result will be in a ResultSet object
                ResultSet result = mystat.executeQuery(SQLselect);
            
                //checking which button was pressed
                if (buttonvalue.equalsIgnoreCase("add"))
                {
                    String inputlName="", inputfName="";
                    double inputGPA=0.;
                
                    while (result.next())
                    {
                        foundstudent = true;
                    }
                    if (foundstudent ==false)
                    {
                        out.println("ID not in database, adding record");
                        
                        //reading the inputs
                        inputlName = request.getParameter("lnameTxtBx");
                        inputfName = request.getParameter("fnameTxtBx");
                        inputGPA = Double.parseDouble(request.getParameter("gpaTxtBx"));
                        out.println("ID: " + inputID + " LName: " + inputlName + " FName: " + inputfName + " GPA: " + inputGPA);
                        
                        //SQL insert record string
                        String SQLinsert = "insert into students values("+inputID +",'"+inputlName+"','"+inputfName+"',"+inputGPA+")";

                        //creating Statement object
                        Statement mystat2 = myconn.createStatement();
                    
                        //running SQLinsert with the Statement object
                        mystat2.executeUpdate(SQLinsert);
                    
                        out.println("Student has been added");
                    }
                    else
                        out.println("Student already exist");
                }
                else
                if (buttonvalue.equalsIgnoreCase("Search"))
                {
                    String lName="", fName="";
                    double sGPA=0.;
                
                    while (result.next())
                    {
                        foundstudent = true;
                        out.println("Student is in database");
                        //reading the student data
                        lName = result.getString("Last");
                        fName = result.getString("First");
                        sGPA = result.getDouble("GPA");
                        out.println("ID: " + inputID + " LastName: " + lName + " FirstName: " + fName + " GPA: " + sGPA);
                    }
                    if (foundstudent ==false)
                    {
                        out.println("Student not in database");
                    }
                }
                else
                if (buttonvalue.equalsIgnoreCase("Update"))
                {
                    String lName="", fName="", SQLupdate="";
                    double sGPA=0.;
                
                    while (result.next())
                    {
                        foundstudent = true;
                        out.println("Student is in database");
                        
                        //reading the student's GPA from the HTML form
                        sGPA = Double.parseDouble(request.getParameter("gpaTxtBx"));
                        
                        //constructing an update SQL string
                        SQLupdate = "update students set GPA="+sGPA+" where ID="+inputID;
                        
                        //creating a Statement object
                        Statement mystat3 = myconn.createStatement();
                        
                        //running the update SQL with the Statement just created
                        mystat3.executeUpdate(SQLupdate);
                        
                        out.println("Student with ID: " + inputID+" has GPA updated");
                    }
                    if (foundstudent ==false)
                    {
                        out.println("Student not in database");
                    }
                }
                else
                if (buttonvalue.equalsIgnoreCase("Delete"))
                {
                    String SQLdelete = "";
                
                    while (result.next())
                    {
                        foundstudent = true;
                        
                        //constructing a delete SQL string
                        SQLdelete = "delete from students where ID="+inputID;
                        
                        //creating a Statement object
                        Statement mystat4 = myconn.createStatement();
                        
                        //running the update SQL with the Statement just created
                        mystat4.executeUpdate(SQLdelete);
                        
                        out.println("Record of student with ID: " + inputID+" has been deleted");
                    }
                    if (foundstudent ==false)
                    {
                        out.println("Student not in database");
                    }
                }
            }   //end of try{}
            
            catch (Exception e){}
        %>
    </body>
