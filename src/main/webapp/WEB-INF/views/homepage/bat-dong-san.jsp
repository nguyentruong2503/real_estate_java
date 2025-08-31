<%@ include file="/WEB-INF/views/taglib.jsp" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>PrimeProperties | Tìm Ngôi Nhà Mơ Ước</title>
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
                        primary: "#1e40af",
                        secondary: "#f97316",
                        dark: "#0f172a",
                        light: "#f8fafc",
                    },
                },
            },
        };
    </script>
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap");
        body {
            font-family: "Inter", sans-serif;
            background-color: #f8fafc;
        }
        .hero-bg {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
            url("https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80");
            background-size: cover;
            background-position: center;
        }
        .property-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1),
            0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        .feature-card {
            transition: all 0.3s ease;
        }
        .feature-card:hover {
            transform: scale(1.05);
        }
        .category-card {
            transition: all 0.3s ease;
        }
        .category-card:hover {
            background-color: #e0f2fe;
        }
        .testimonial-card {
            transition: all 0.3s ease;
        }
        .testimonial-card:hover {
            transform: translateY(-5px);
        }
    </style>
</head>
<body class="bg-light">
<!-- Header -->
<header class="bg-white shadow-md sticky top-0 z-50">
    <div
            class="container mx-auto px-4 py-4 flex justify-between items-center"
    >
        <div class="flex items-center">
            <div
                    class="bg-primary w-10 h-10 rounded-lg flex items-center justify-center"
            >
                <i class="fas fa-home text-white text-2xl"></i>
            </div>
            <span class="ml-2 text-2xl font-bold text-dark">
            Prime<span class="text-secondary">Properties</span>
          </span>
        </div>

        <nav class="hidden md:flex space-x-8">
            <a
                    href="/homepage/trang-chu"
                    class="text-dark font-medium hover:text-secondary transition"
            >Trang Chủ</a
            >
            <a
                    href="#"
                    class="text-dark font-medium hover:text-secondary transition"
            >Bất Động Sản</a
            >
            <a
                    href="/homepage/gioi-thieu"
                    class="text-dark font-medium hover:text-secondary transition"
            >Giới thiệu</a
            >
            <a
                    href="#"
                    class="text-dark font-medium hover:text-secondary transition"
            >Tin tức</a
            >
            <a
                    href="/homepage/lien-he"
                    class="text-dark font-medium hover:text-secondary transition"
            >Liên Hệ</a
            >
        </nav>

        <div class="flex items-center space-x-4">
            <button
                    class="hidden md:block bg-primary hover:bg-blue-800 text-white px-5 py-2 rounded-lg font-medium transition"
            >
                Đăng Tin BĐS
            </button>
            <security:authorize access="isAnonymous()">
                <!-- Khi CHƯA đăng nhập -->
                <a
                        href="/login"
                        class="bg-secondary hover:bg-orange-600 text-white px-4 py-2 rounded-lg font-medium transition"
                >
                    Đăng Nhập
                </a>
            </security:authorize>

            <security:authorize access="isAuthenticated()">
                <!-- Khi ĐÃ đăng nhập -->
                <a
                        href="/home"
                        class="bg-primary hover:bg-blue-800 text-white px-4 py-2 rounded-lg font-medium transition"
                >
                    Trang Quản Trị
                </a>
            </security:authorize>

            <button class="md:hidden text-dark">
                <i class="fas fa-bars text-2xl"></i>
            </button>
        </div>
    </div>
</header>

<!-- Hero Section -->
<section class="hero-bg text-white py-20">
    <div class="container mx-auto px-4">
        <div class="max-w-2xl">
            <h1 class="text-4xl md:text-5xl font-bold leading-tight mb-4">
                Tìm Ngôi Nhà Mơ Ước Với PrimeProperties
            </h1>
            <p class="text-xl mb-8">
                Khám phá nơi lý tưởng để gọi là nhà. Chúng tôi cung cấp những bất
                động sản tốt nhất cho thuê và bán tại các vị trí đắc địa.
            </p>
            <div class="flex flex-col sm:flex-row gap-4">
                <button
                        class="bg-secondary hover:bg-orange-600 text-white px-6 py-3 rounded-lg font-medium text-lg transition"
                >
                    Xem Bất Động Sản
                </button>
                <button
                        class="bg-transparent border-2 border-white hover:bg-white/10 text-white px-6 py-3 rounded-lg font-medium text-lg transition"
                >
                    Liên Hệ Đại Lý
                </button>
            </div>
        </div>
    </div>
</section>

<!-- Search Section -->
<section
        class="bg-white py-10 -mt-10 shadow-lg relative z-10 mx-4 md:mx-10 rounded-xl"
>
    <div class="container mx-auto px-4">
        <div class="bg-white rounded-lg p-6 shadow-md">
            <h2 class="text-2xl font-bold text-dark mb-6">
                Tìm Bất Động Sản Lý Tưởng
            </h2>
            <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                <div>
                    <label class="block text-gray-700 mb-2">Vị Trí</label>
                    <div class="relative">
                        <input
                                type="text"
                                placeholder="Thành phố, Khu vực hoặc Tòa nhà"
                                class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
                        />
                        <i
                                class="fas fa-search absolute right-3 top-4 text-gray-400"
                        ></i>
                    </div>
                </div>
                <div>
                    <label class="block text-gray-700 mb-2">Loại BĐS</label>
                    <select
                            class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
                    >
                        <option>Tất cả loại</option>
                        <option>Căn hộ</option>
                        <option>Nhà ở</option>
                        <option>Văn phòng</option>
                        <option>Thương mại</option>
                    </select>
                </div>
                <div>
                    <label class="block text-gray-700 mb-2">Khoảng Giá</label>
                    <select
                            class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
                    >
                        <option>Bất kỳ</option>
                        <option>$500 - $1,000</option>
                        <option>$1,000 - $2,000</option>
                        <option>$2,000 - $5,000</option>
                        <option>$5,000+</option>
                    </select>
                </div>
                <div class="flex items-end">
                    <button
                            class="w-full bg-primary hover:bg-blue-800 text-white px-6 py-3 rounded-lg font-medium transition"
                    >
                        Tìm Kiếm
                    </button>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Featured Properties -->
<section class="py-16 bg-light">
    <div class="container mx-auto px-4">
        <div class="text-center mb-12">
            <h2 class="text-3xl font-bold text-dark mb-4">Bất Động Sản của chúng tôi</h2>
            <p class="text-gray-600 max-w-2xl mx-auto">
                Khám phá những bất động sản được lựa chọn kỹ lưỡng dành cho thuê
            </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <c:forEach var="building" items="${model.listResult}">
                <a href="<c:url value='/homepage/building-view-${building.id}'/>">
                    <div class="property-card bg-white rounded-xl overflow-hidden shadow-md transition">
                        <div class="relative">
                            <!-- Hình ảnh -->
                            <c:choose>
                                <c:when test="${not empty building.imageUrls}">
                                    <img src="${building.imageUrls[0]}" alt="${building.name}"
                                         class="w-full h-60 object-cover"/>
                                </c:when>
                                <c:otherwise>
                                    <img src="https://via.placeholder.com/600x400"
                                         alt="No Image" class="w-full h-60 object-cover"/>
                                </c:otherwise>
                            </c:choose>

                            <!-- Trạng thái -->
                            <div class="absolute top-4 right-4 bg-secondary text-white px-3 py-1 rounded-full text-sm font-bold">
                                    ${building.status}
                            </div>

                            <!-- Giá -->
                            <div class="absolute bottom-4 left-4 bg-white px-3 py-1 rounded-full text-sm font-bold text-red-600">
                                <fmt:formatNumber value="${building.rentPrice}" type="number" groupingUsed="true"/> VNĐ
                            </div>
                        </div>

                        <div class="p-6">
                            <h3 class="text-xl font-bold text-dark mb-2">${building.name}</h3>
                            <p class="text-gray-600 mb-4">
                                <i class="fas fa-map-marker-alt text-secondary mr-2"></i>
                                    ${building.address}
                            </p>

                            <div class="flex justify-between border-t border-gray-200 pt-4">
                                <div class="flex items-center">
                                    <i class="fas fa-building text-gray-500 mr-1"></i>
                                    <span class="text-gray-700">${building.numberOfBasement} Hầm</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-ruler-combined text-gray-500 mr-1"></i>
                                    <span class="text-gray-700">${building.floorArea} m²</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-compass text-gray-500 mr-1"></i>
                                    <span class="text-gray-700">${building.direction}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>

    </div>
</section>

<!-- CTA Section -->
<section class="py-16 bg-primary text-white text-center">
    <div class="container mx-auto px-4">
        <h2 class="text-3xl md:text-4xl font-bold mb-4">
            Sẵn Sàng Tìm Ngôi Nhà Mơ Ước?
        </h2>
        <p class="text-lg mb-8">
            Bắt đầu hành trình tìm bất động sản phù hợp với bạn ngay hôm nay.
        </p>
        <button
                class="bg-secondary hover:bg-orange-600 px-8 py-3 rounded-lg font-medium text-lg transition"
        >
            Liên Hệ Ngay
        </button>
    </div>
</section>

<!-- Footer -->
<footer class="bg-dark text-white py-12">
    <div class="container mx-auto px-4 grid grid-cols-1 md:grid-cols-4 gap-8">
        <div>
            <h3 class="font-bold text-xl mb-4">PrimeProperties</h3>
            <p class="text-gray-300">
                Mang đến giải pháp bất động sản nhanh chóng và uy tín cho mọi khách
                hàng.
            </p>
        </div>
        <div>
            <h4 class="font-bold mb-4">Liên Kết</h4>
            <ul>
                <li class="mb-2">
                    <a href="#" class="text-gray-300 hover:text-secondary transition"
                    >Trang Chủ</a
                    >
                </li>
                <li class="mb-2">
                    <a href="#" class="text-gray-300 hover:text-secondary transition"
                    >Bất Động Sản</a
                    >
                </li>
                <li class="mb-2">
                    <a href="#" class="text-gray-300 hover:text-secondary transition"
                    >Đại Lý</a
                    >
                </li>
                <li class="mb-2">
                    <a href="#" class="text-gray-300 hover:text-secondary transition"
                    >Liên Hệ</a
                    >
                </li>
            </ul>
        </div>
        <div>
            <h4 class="font-bold mb-4">Dịch Vụ</h4>
            <ul>
                <li class="mb-2">
                    <a href="#" class="text-gray-300 hover:text-secondary transition"
                    >Tư Vấn</a
                    >
                </li>
                <li class="mb-2">
                    <a href="#" class="text-gray-300 hover:text-secondary transition"
                    >Cho Thuê</a
                    >
                </li>
                <li class="mb-2">
                    <a href="#" class="text-gray-300 hover:text-secondary transition"
                    >Quản Lý</a
                    >
                </li>
            </ul>
        </div>
        <div>
            <h4 class="font-bold mb-4">Liên Hệ</h4>
            <p class="text-gray-300">54, Phố Triều Khúc, Thanh Xuân, Hà Nội</p>
            <p class="text-gray-300">Email: info@primeproperties.vn</p>
            <p class="text-gray-300">Điện thoại: +84 123 456 789</p>
        </div>
    </div>

    <div class="text-center text-gray-500 mt-8">
        &copy; 2025 PrimeProperties. Bảo lưu mọi quyền.
    </div>
</footer>
</body>
</html>

