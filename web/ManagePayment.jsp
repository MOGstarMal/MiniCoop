<%-- 
    Document   : ManagePayment
    Created on : 5 Jun 2023, 06:41:39
    Author     : Lenovo
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
    <jsp:useBean id="receiptnum" class="com.model.Reciept" scope="request"/>

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Staff</title>
        <link rel="stylesheet" type="text/css" href="CSS/ManagePayment.css">
    </head>
    <!-- Navigation Bar -->

    <body>
        <header>
            <div class="main">
                <img class="logo" src="IMG/logoRe.png" alt="logo">
                <nav>
                    <ul class="nav_links">
                        <li><a href="ManagePayment.jsp ">Manage Payment</a></li>
                        <li><a href="ManageProduct.jsp">Manage Product</a></li>
                    </ul>
                </nav>
            </div>
            <nav>
                <li class="dropdown">
                    <a class="nav-link">Account</a>
                    <ul class="dropdown-content">
                        <!--                        <li><a href="ManagerProfile.html">Edit Information</a></li>-->
                        <li><a href="StartPage.html">Sign Out</a></li>
                    </ul>
                </li>
                <!-- <a href="CustomerProfile.html"><img class="profilePic" src="profileImg.png" alt="profileImg"></a> -->
            </nav>



        </header>

        <div class="form-group" style="margin: 15px;">
            <form id="form" action="" method="POST">
                <label for="receiptNumber">Receipt Number</label>
                <input type="text" id="inputreceiptNumber" name="receiptNumber">
                <input type="submit" id="btnsubmit" value="search"/>

        </div>

        <!--Page-->
        <div class="payment-history-section">
            <h3>Payment History</h3>

            <table>
                <thead>
                    <tr>
                        <th>Receipt Number</th>
                        <th>Customer Name</th>
                        <th>Product Name</th>
                        <th>Quantity</th>
                    </tr>
                </thead>

                <tbody>
                    <!-- <c:forEach items="${receipt}" var="receipt" -->

                    <%
                        try {
                        
                            receiptnum.setReceiptNumber(request.getParameter("receiptNumber"));
                            ResultSet rs;
                            PreparedStatement st;
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minicoop2", "root", "admin");
                            String receiptid = receiptnum.getReceiptNumber();

                            if (receiptid == null || receiptid.isEmpty()) {
                                st = con.prepareStatement("SELECT * FROM receipt");
                                rs = st.executeQuery();

                                while (rs.next()) {
                    %>
                    <tr>
                        <td><%=rs.getInt("receipt_ID")%></td>
                        <td><%=rs.getString("cust_Name")%></td>
                        <td><%=rs.getString("prod_Name")%></td>
                        <td><%=rs.getString("prod_Qty")%></td>
                    </tr>

                    <%
                        }
                    } else {
                        st = con.prepareStatement("SELECT * FROM receipt where receipt_ID =?");

                        st.setString(1, receiptnum.getReceiptNumber());
                        rs = st.executeQuery();
                        while (rs.next()) {
                    %>

                    <tr>
                        <td><%=rs.getInt("receipt_ID")%></td>
                        <td><%=rs.getString("cust_Name")%></td>
                        <td><%=rs.getString("prod_Name")%></td>
                        <td><%=rs.getString("prod_Qty")%></td>
                    </tr>
                    <%
                                }
                            }
                        } catch (Exception e) {

                        }
                    %>

                </tbody>
            </table>
        </div>
                     <jsp:include flush="true" page="Footer.jsp" />
    </body>

</html>
