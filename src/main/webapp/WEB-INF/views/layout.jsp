<%@ page import="com.example.realestate.security.SecurityUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/taglib.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="activeMenu" value="${activeMenu}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Real Estate Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    />
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: "#3B82F6",
                        secondary: "#1E40AF",
                        accent: "#10B981",
                        dark: "#1F2937",
                        light: "#F9FAFB",
                    },
                },
            },
        };
    </script>
    <style>
        .sidebar {
            transition: all 0.3s ease;
        }
        .sidebar.collapsed {
            width: 70px;
        }
        .sidebar.collapsed .sidebar-text {
            display: none;
        }
        .sidebar.collapsed .logo-text {
            display: none;
        }
        .sidebar.collapsed .nav-item {
            justify-content: center;
        }
        .content {
            transition: all 0.3s ease;
        }
        .content.expanded {
            margin-left: 70px;
        }
        @media (max-width: 768px) {
            .sidebar {
                position: absolute;
                z-index: 100;
                left: -250px;
            }
            .sidebar.active {
                left: 0;
            }
            .content.expanded {
                margin-left: 0;
            }
        }

        /* Search dropdown animation */
        .search-dropdown {
            opacity: 0;
            transform: translateY(-10px);
            transition: all 0.2s ease;
            pointer-events: none;
        }
        .search-dropdown.show {
            opacity: 1;
            transform: translateY(0);
            pointer-events: auto;
        }


    </style>
</head>
<body class="bg-gray-100 flex h-screen overflow-hidden">


    <div class="flex flex-1 overflow-hidden">
        <!-- Sidebar -->
        <div
                id="sidebar"
                class="sidebar bg-white text-gray-800 w-64 shadow-lg flex flex-col h-full"
        >
            <!-- Logo -->
            <div class="p-4 flex items-center border-b border-gray-200">
                <div class="bg-primary p-2 rounded-lg">
                    <i class="fas fa-building text-white text-xl"></i>
                </div>
                <span class="logo-text ml-3 text-xl font-bold text-primary"
                >RealEstatePro</span
                >
            </div>

            <!-- User Profile -->
            <div class="p-4 flex items-center border-b border-gray-200">
                <div
                        class="w-10 h-10 rounded-full bg-primary flex items-center justify-center text-white"
                >
                    <i class="fas fa-user"></i>
                </div>
                <div class="ml-3 sidebar-text">
                    <div class="font-medium"><%=SecurityUtils.getPrimaryRole()%></div>
                    <div class="text-xs text-gray-500"><%=SecurityUtils.getPrincipal().getFullName()%></div>
                </div>
            </div>

            <!-- Navigation -->
            <nav class="flex-1 overflow-y-auto py-4">
                <div class="space-y-1 px-4">

                    <a
                            href="/homepage/trang-chu"
                            class="nav-item flex items-center px-3 py-2 text-sm font-medium rounded-md text-gray-600 hover:bg-gray-100"
                    >
                        <i class="fa-solid fa-house-user mr-3"></i>
                        <span class="sidebar-text">Trang chủ</span>
                    </a>

                    <!-- Buildings -->
                    <a href="${ctx}/admin/building-list"
                       class="nav-item flex items-center px-3 py-2 text-sm font-medium rounded-md
            ${activeMenu eq 'building' ? 'bg-primary text-white' : 'text-gray-600 hover:bg-gray-100'}">
                        <i class="fas fa-building mr-3"></i>
                        <span class="sidebar-text">Buildings</span>
                    </a>

                    <!-- Customers -->
                    <a href="${ctx}/admin/customer-list"
                       class="nav-item flex items-center px-3 py-2 text-sm font-medium rounded-md
            ${activeMenu eq 'customer' ? 'bg-primary text-white' : 'text-gray-600 hover:bg-gray-100'}">
                        <i class="fas fa-home mr-3"></i>
                        <span class="sidebar-text">Customer</span>
                    </a>

                    <a href="${ctx}/admin/user-list"
                       class="nav-item flex items-center px-3 py-2 text-sm font-medium rounded-md
           ${fn:contains(currentUrl, '/user-list') ? 'bg-primary text-white' : 'text-gray-600 hover:bg-gray-100'}">
                        <i class="fas fa-users mr-3"></i>
                        <span class="sidebar-text">Users</span>
                    </a>

                    <!-- Reports -->
                    <a href="${ctx}/admin/report-list"
                       class="nav-item flex items-center px-3 py-2 text-sm font-medium rounded-md
           ${fn:contains(currentUrl, '/report-list') ? 'bg-primary text-white' : 'text-gray-600 hover:bg-gray-100'}">
                        <i class="fas fa-chart-line mr-3"></i>
                        <span class="sidebar-text">Reports</span>
                    </a>

                    <!-- Settings -->
                    <a href="${ctx}/admin/settings"
                       class="nav-item flex items-center px-3 py-2 text-sm font-medium rounded-md
           ${fn:contains(currentUrl, '/settings') ? 'bg-primary text-white' : 'text-gray-600 hover:bg-gray-100'}">
                        <i class="fas fa-cog mr-3"></i>
                        <span class="sidebar-text">Settings</span>
                    </a>

                </div>
            </nav>

            <!-- Collapse Button -->
            <div class="p-4 border-t border-gray-200">
                <button
                        id="toggleSidebar"
                        class="w-full flex items-center justify-center text-gray-500 hover:text-primary"
                >
                    <i class="fas fa-chevron-left"></i>
                    <span class="sidebar-text ml-2">Collapse</span>
                </button>
            </div>
        </div>

        <div class="flex-1 flex flex-col h-screen">
            <!-- Header -->
            <header class="bg-white shadow-sm">
                <div class="px-4 py-3 flex items-center justify-between">
                    <div class="flex items-center">
                        <button id="mobileMenuButton" class="md:hidden text-gray-500 mr-2">
                            <i class="fas fa-bars text-xl"></i>
                        </button>
                        <h1 class="text-xl font-semibold text-gray-800">
                            Trang quản trị
                        </h1>
                    </div>
                    <div class="flex items-center space-x-4">

                        <div class="relative">
                            <button class="text-gray-500 hover:text-primary">
                                <i class="fas fa-bell text-xl"></i>
                                <span class="absolute top-0 right-0 h-2 w-2 rounded-full bg-red-500"></span>
                            </button>
                        </div>
                        <div class="relative">
                            <a href="/admin/changePass" class="text-gray-500 hover:text-primary" title="Đổi mật khẩu">
                                <i class="fas fa-cog text-xl"></i>
                                <span class="absolute top-0 right-0 h-2 w-2 rounded-full bg-red-500"></span>
                            </a>
                        </div>
                        <div class="border-l border-gray-200 h-8"></div>
                        <div class="flex items-center">
                            <div class="w-8 h-8 rounded-full bg-primary flex items-center justify-center text-white">
                                <i class="fas fa-user"></i>
                            </div>
                            <span class="ml-2 hidden md:inline">
                                <%=SecurityUtils.getPrincipal().getFullName()%>
                            </span>
                            <form action="<c:url value='/logout'/>" method="post" class="ml-3">
                                <button type="submit"
                                        class="px-3 py-1 bg-red-500 hover:bg-red-600 text-white rounded-md text-sm">
                                    Logout
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </header>

            <!-- Main Content -->
            <div id="content" class="flex-1 overflow-y-auto h-screen p-4 bg-light">
                <c:import url="/WEB-INF/views/${contentPage}" />
            </div>

        </div>

    </div>


        <script>
        // Sidebar toggle
        const toggleSidebar = document.getElementById("toggleSidebar");
        const sidebar = document.getElementById("sidebar");
        const content = document.getElementById("content");

        toggleSidebar.addEventListener("click", () => {
            sidebar.classList.toggle("collapsed");
            content.classList.toggle("expanded");

            toggleSidebar.innerHTML = sidebar.classList.contains("collapsed")
                ? '<i class="fas fa-chevron-right"></i><span class="sidebar-text ml-2">Expand</span>'
                : '<i class="fas fa-chevron-left"></i><span class="sidebar-text ml-2">Collapse</span>';
        });

    </script>
</body>
</html>

