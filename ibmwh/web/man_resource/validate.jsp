<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="myFunc" uri="myFunctions"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

	  <%-- 验证用户是否已经登录 --%>
	 <c:if test="${validUser == null}">
	 	<c:redirect url="/web/man_pages/login.jsp">
	 		<c:param name="origURL" value="${pageContext.request.requestURL}"/>
	 		<c:param name="errorMsg" value="还未登录账户"/>
 	 	</c:redirect>
	 
	 </c:if>
	 	 <c:if test="${ ! fn:containsIgnoreCase(validUser.admin, 'AM') && ! fn:containsIgnoreCase(validUser.admin, 'RM')}">
	 	<c:redirect url="/web/man_pages/login.jsp">
	 		<c:param name="origURL" value="${pageContext.request.requestURL}"/>
	 		<c:param name="errorMsg" value="当前账户没有修改资源权限，请重新登录其他账号"/>
		</c:redirect>	 	
	 </c:if>

