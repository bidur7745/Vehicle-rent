<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="bg-white shadow">
    <div class="max-w-7xl mx-auto py-4 px-4 sm:px-6 lg:px-8 flex justify-between items-center">
        <h1 class="text-2xl font-bold text-gray-900">
            <c:out value="${pageTitle}" default="Dashboard"/>
        </h1>
        <div class="flex items-center space-x-4">
            <div class="text-sm text-gray-700">
                Welcome, <span class="font-semibold">${sessionScope.user.firstName}</span>
            </div>
            <form action="${pageContext.request.contextPath}/logout" method="post" class="inline">
                <button type="submit" class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">
                    Logout
                </button>
            </form>
        </div>
    </div>
</header> 