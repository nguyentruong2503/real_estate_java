<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/taglib.jsp" %>
<c:url var="userListURL" value="/admin/user-list"/>
<c:url var="userAPI" value="/api/user"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Account Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

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

        .pagebanner {
            display: none; /* Ẩn text "8 items found..." */
        }
        .pagelinks {
            display: none; /* Ẩn nút phân trang mặc định */
        }

        /* Custom animation for modal */
        @keyframes modalFadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .modal-animation {
            animation: modalFadeIn 0.3s ease-out forwards;
        }

        /* Custom scrollbar for employee list */
        .employee-list::-webkit-scrollbar {
            width: 6px;
        }

        .employee-list::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }

        .employee-list::-webkit-scrollbar-thumb {
            background: #888;
            border-radius: 10px;
        }

        .employee-list::-webkit-scrollbar-thumb:hover {
            background: #555;
        }

    </style>
</head>
<body class="bg-gray-100 font-sans">

<main class="flex-1 overflow-y-auto p-4 md:p-6 bg-gray-50">
    <!-- Page Header -->
    <div
            class="flex flex-col md:flex-row justify-between items-start md:items-center mb-6 gap-4"
    >
        <div>
            <h2 class="text-2xl font-bold text-gray-800">Account Management</h2>
            <p class="text-sm text-gray-500 mt-1">
                Manage all your account
            </p>
        </div>

        <div class="flex flex-col md:flex-row gap-3 w-full md:w-auto">
            <!-- Advanced Search Button -->
            <button
                    id="advancedSearchToggle"
                    class="flex items-center justify-center md:justify-start text-primary border border-primary bg-white hover:bg-blue-50 px-4 py-2 rounded-lg"
            >
                <i class="fas fa-sliders-h mr-2"></i>
                <span>Advanced Search</span>
            </button>

            <a href="/admin/user-edit">
                <button
                        class="bg-primary hover:bg-blue-700 text-white px-4 py-2 rounded-lg flex items-center justify-center"
                >
                    <i class="fas fa-plus mr-2"></i>
                    Thêm mới tài khoản
                </button>
            </a>

        </div>
    </div>

    <!-- Advanced Search Panel -->
    <div
            id="advancedSearchPanel"
            class="bg-white rounded-lg shadow overflow-hidden mb-6 hidden transition-all duration-300"
    >
        <div
                class="p-4 border-b border-gray-200 flex justify-between items-center"
        >
            <h3 class="font-medium text-gray-800">Tìm kiếm nâng cao</h3>
            <button
                    id="closeAdvancedSearch"
                    class="text-gray-500 hover:text-gray-700"
            >
                <i class="fas fa-times"></i>
            </button>
        </div>

        <!-- Form Grid -->

        <form:form id="listForm" modelAttribute="userDTO" action="${userListURL}" method="GET"
                   class="p-4 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4" >
            <!-- Tên tòa nhà -->
            <div>
                <label
                        class="block text-sm font-medium text-gray-700 mb-1"
                >Giá trị cần tìm</label
                >
                <form:input path="searchValue"
                            type="text"
                            class="w-full border px-3 py-2 rounded-md"
                            placeholder="Nhập tên đăng nhập hoặc họ tên người dùng"
                />
            </div>


            <div
                    class="p-4 bg-gray-50 border-t border-gray-200 flex justify-end gap-3"
            >
                <button
                        type="reset"
                        id="resetSearch"
                        class="px-4 py-2 text-gray-700 hover:text-gray-900 rounded-lg border"
                >
                    Reset
                </button>
                <button
                        id="btnSearch"
                        class="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg"
                >
                    Tìm kiếm
                </button>
            </div>
        </form:form>

    </div>

    <div class="bg-white rounded-lg shadow overflow-hidden">
        <div class="overflow-x-auto">
            <table id="tableList" class="min-w-full divide-y divide-gray-200">
                <display:table
                        name="userDTO.listResult"
                        requestURI="${userListURL}"
                        partialList="true"
                        sort="external"
                        size="${userDTO.totalItems}"
                        defaultsort="1"
                        defaultorder="ascending"
                        id="tableList"
                        pagesize="${userDTO.maxPageItems}"
                        export="false"
                        class="min-w-full divide-y divide-gray-200"
                >
                    <display:column property="id" style="display:none;" headerClass="hidden" class="hidden"/>

                    <display:column title="Tên đăng nhập" property="userName"
                                    headerClass="px-6 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider text-center"
                                    class="px-6 py-4 text-sm text-gray-900 text-center"/>

                    <display:column title="Họ tên người dùng" property="fullName"
                                    headerClass="px-6 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider text-center"
                                    class="px-6 py-4 text-sm text-gray-900 text-center"/>


                    <display:column title="Thao tác" headerClass="px-6 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider text-center">
                        <div class="flex space-x-2 justify-center">
                            <c:if test="${tableList.roleCode != 'MANAGER'}">
                                <a class="text-blue-600 hover:text-blue-900" href="/admin/user-edit-${tableList.id}" title="Sửa">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <security:authorize access="hasRole('MANAGER')">
                                    <button class="text-red-600 hover:text-red-900" onclick="deleteUser(${tableList.id})" title="Xóa">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </security:authorize>
                            </c:if>
                            <c:if test="${tableList.roleCode == 'MANAGER'}">
                                <p>Không đươc thao tác</p>
                            </c:if>
                        </div>
                    </display:column>
                </display:table>
            </table>
        </div>
    </div>

    <!-- Pagination -->
    <div class="flex items-center justify-between mt-6 bg-white px-4 py-3 rounded-lg shadow">
        <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
            <div>
                <p class="text-sm text-gray-700">
                    Showing
                    <span class="font-medium">${(userDTO.page - 1) * userDTO.maxPageItems + 1}</span>
                    to
                    <span class="font-medium">
                    <c:choose>
                        <c:when test="${userDTO.page * userDTO.maxPageItems > userDTO.totalItems}">
                            ${userDTO.totalItems}
                        </c:when>
                        <c:otherwise>
                            ${userDTO.page * userDTO.maxPageItems}
                        </c:otherwise>
                    </c:choose>
                </span>
                    of
                    <span class="font-medium">${userDTO.totalItems}</span> users
                </p>
            </div>

            <div>
                <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                    <!-- Previous -->
                    <c:if test="${userDTO.page > 1}">
                        <c:url var="prevUrl" value="${userListURL}">
                            <c:param name="d-3677046-p" value="${userDTO.page - 1}" />
                        </c:url>
                        <a href="${prevUrl}"
                           class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </c:if>

                    <!-- Page numbers -->
                    <c:forEach var="i" begin="1" end="${userDTO.totalPage}">
                        <c:url var="pageUrl" value="${userListURL}">
                            <c:param name="d-3677046-p" value="${i}" />
                        </c:url>
                        <a href="${pageUrl}"
                           class="${i == userDTO.page ? 'z-10 bg-primary border-primary text-white' : 'bg-white border-gray-300 text-gray-500 hover:bg-gray-50'} relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                                ${i}
                        </a>
                    </c:forEach>

                    <!-- Next -->
                    <c:if test="${userDTO.page < userDTO.totalPage}">
                        <c:url var="nextUrl" value="${userListURL}">
                            <c:param name="d-3677046-p" value="${userDTO.page + 1}" />
                        </c:url>
                        <a href="${nextUrl}"
                           class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </c:if>

                </nav>
            </div>
        </div>
    </div>


</main>

<script>
    const advancedSearchToggle = document.getElementById(
        "advancedSearchToggle"
    );
    const advancedSearchPanel = document.getElementById(
        "advancedSearchPanel"
    );
    const closeAdvancedSearch = document.getElementById(
        "closeAdvancedSearch"
    );

    // Mở hoặc ẩn panel tìm kiếm nâng cao
    advancedSearchToggle.addEventListener("click", () => {
        advancedSearchPanel.classList.toggle("hidden");
    });

    // Đóng panel khi nhấn nút đóng
    closeAdvancedSearch.addEventListener("click", () => {
        advancedSearchPanel.classList.add("hidden");
    });

    $('#btnSearch').click(function (e){
        e.preventDefault();
        $('#listForm').submit();
    });

    function deleteUser(id) {
        var userId = [id];
        deleteUsers(userId);
    }

    function deleteUsers(data){
        $.ajax({
            type: "DELETE",
            url: "${userAPI}/" +data,
            data: JSON.stringify(data),
            success: function (response) {
                console.log("ok rồi nhé anh ba");
                data.forEach(function(id) {
                    $("#tableList tbody tr").filter(function() {
                        return $(this).find("td.hidden").text().trim() == id;
                    }).remove();
                });

            },
            error: function (response) {
                console.log("lỗi rồi anh ba");
                console.log(response);
            }
        });
    }
</script>
</body>
</html>

