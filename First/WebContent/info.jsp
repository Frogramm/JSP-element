<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.koit.first.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>

<%
//사이에 자바 문법 사용 가능
		Class.forName("oracle.jdbc.driver.OracleDriver");

		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String userName = "hr";
		String password = "koreait2020";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM countries";
		
		List<CountriesVO> list = new ArrayList();
		
		try{
		con = DriverManager.getConnection(url, userName, password);
		ps = con.prepareStatement(sql); //커넥션의 주소값도 가지고 있음.
		rs = ps.executeQuery(); //실제 쿼리문 실행하는 부분
		while(rs.next()){
			String country_id = rs.getString("country_id");
			String country_name = rs.getString("country_name");
			int region_id = rs.getInt("region_id");
			CountriesVO vo = new CountriesVO();
			vo.setCountry_id(country_id);
			vo.setCountry_name(country_name);
			vo.setRegion_id(region_id);
			list.add(vo);
		}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				rs.close();
				ps.close();
				con.close();
			}catch(Exception e){
				
			}
		}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Info</title>
</head>
<body>
	<div>인포메이션</div>
		<table>
			<tr>
				<th>country_id</th>
				<th>나라명</th>
				<th>지역ID</th>
			</tr>
			<% for(CountriesVO vo : list) {%>
			<tr>
				<td><%=vo.getCountry_id() %></td>
				<td><%=vo.getCountry_name() %></td>
				<td><%=vo.getRegion_id() %></td>
			</tr>
			<% } %>
		</table>
</body>
</html>