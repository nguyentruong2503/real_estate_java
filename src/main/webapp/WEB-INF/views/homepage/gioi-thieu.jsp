<%@ include file="/WEB-INF/views/taglib.jsp" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>PrimeProperties | Find Your Dream Property</title>
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
            <span class="ml-2 text-2xl font-bold text-dark"
            >Prime<span class="text-secondary">Properties</span></span
            >
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
            <sec:authorize access="isAnonymous()">
                <!-- Khi CHƯA đăng nhập -->
                <a
                        href="/login"
                        class="bg-secondary hover:bg-orange-600 text-white px-4 py-2 rounded-lg font-medium transition"
                >
                    Đăng Nhập
                </a>
            </sec:authorize>

            <sec:authorize access="isAuthenticated()">
                <!-- Khi ĐÃ đăng nhập -->
                <a
                        href="/home"
                        class="bg-primary hover:bg-blue-800 text-white px-4 py-2 rounded-lg font-medium transition"
                >
                    Trang Quản Trị
                </a>
            </sec:authorize>
            <button class="md:hidden text-dark">
                <i class="fas fa-bars text-2xl"></i>
            </button>
        </div>
    </div>
</header>

<!-- About Us Section -->
<section class="py-16 bg-white">
    <div class="container mx-auto px-4">
        <div class="text-center mb-12">
            <h2 class="text-3xl font-bold text-dark mb-4">
                Giới thiệu về PrimeProperties
            </h2>
            <p class="text-gray-600 max-w-2xl mx-auto">
                Tìm hiểu thêm về công ty, sứ mệnh và đội ngũ đằng sau thành công của chúng tôi
            </p>
        </div>

        <div class="flex flex-col lg:flex-row gap-12 items-center">
            <div class="lg:w-1/2">
                <h3 class="text-2xl font-bold text-dark mb-4">Câu chuyện của chúng tôi</h3>
                <p class="text-gray-700 mb-6">
                    Được thành lập vào năm 2010, PrimeProperties đã phát triển trở thành một trong những
                    công ty môi giới bất động sản hàng đầu cả nước. Hành trình của chúng tôi bắt đầu
                    với một tầm nhìn đơn giản: cách mạng hóa thị trường bất động sản bằng cách
                    cung cấp dịch vụ đặc biệt và chuyên môn vượt trội cho
                    khách hàng của chúng tôi.
                </p>
                <p class="text-gray-700 mb-6">
                    Trong nhiều năm qua, chúng tôi đã giúp hàng ngàn khách hàng tìm được bất động sản mơ ước, dù họ đang tìm kiếm một căn hộ ấm cúng, một biệt thự sang trọng hay một không gian thương mại để phát triển doanh nghiệp. Thành công của chúng tôi không chỉ được đo lường bằng số lượng bất động sản bán được, mà còn bằng sự hài lòng của khách hàng.
                </p>

                <div class="grid grid-cols-2 gap-6 mt-8">
                    <div class="text-center p-4 bg-blue-50 rounded-lg">
                        <div class="text-3xl font-bold text-primary mb-2">12+</div>
                        <div class="text-gray-700">Năm kinh nghiệm</div>
                    </div>
                    <div class="text-center p-4 bg-orange-50 rounded-lg">
                        <div class="text-3xl font-bold text-secondary mb-2">5000+</div>
                        <div class="text-gray-700">BĐS đã trao đến tay khách hàng</div>
                    </div>
                    <div class="text-center p-4 bg-green-50 rounded-lg">
                        <div class="text-3xl font-bold text-green-600 mb-2">25+</div>
                        <div class="text-gray-700">Đại lý trên khắp 3 miền tổ quốc</div>
                    </div>
                    <div class="text-center p-4 bg-purple-50 rounded-lg">
                        <div class="text-3xl font-bold text-purple-600 mb-2">98%</div>
                        <div class="text-gray-700">Sự hài lòng của khách hàng</div>
                    </div>
                </div>
            </div>

            <div class="lg:w-1/2">
                <div class="grid grid-cols-2 gap-4">
                    <img
                            src="https://images.unsplash.com/photo-1560448204-603b3fc33ddc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80"
                            alt="Office team"
                            class="rounded-xl shadow-md h-64 object-cover"
                    />
                    <img
                            src="https://images.unsplash.com/photo-1560185893-a55cbc8c57e8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1469&q=80"
                            alt="Meeting"
                            class="rounded-xl shadow-md mt-8 h-64 object-cover"
                    />
                    <img
                            src="https://images.unsplash.com/photo-1573164713988-8665fc963095?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1469&q=80"
                            alt="Office space"
                            class="rounded-xl shadow-md h-64 object-cover"
                    />
                    <img
                            src="https://images.unsplash.com/photo-1556761175-5973dc0f32e7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1332&q=80"
                            alt="Team"
                            class="rounded-xl shadow-md mt-8 h-64 object-cover"
                    />
                </div>
            </div>
        </div>

        <section class="py-16 bg-light">
            <div class="container mx-auto px-4">
                <div class="text-center mb-12">
                    <h2 class="text-3xl font-bold text-dark mb-4">Tại Sao Chọn Chúng Tôi?</h2>
                    <p class="text-gray-600 max-w-2xl mx-auto">
                        Chúng tôi mang đến những giá trị vượt trội cho khách hàng trong mỗi giao dịch.
                    </p>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                    <div class="feature-card bg-white rounded-xl shadow-md p-8 text-center">
                        <i class="fas fa-medal text-secondary text-4xl mb-4"></i>
                        <h3 class="text-xl font-bold text-dark mb-2">Uy Tín Hàng Đầu</h3>
                        <p class="text-gray-600">
                            Hơn 10 năm kinh nghiệm và hàng nghìn khách hàng hài lòng trên toàn quốc.
                        </p>
                    </div>
                    <div class="feature-card bg-white rounded-xl shadow-md p-8 text-center">
                        <i class="fas fa-search-dollar text-secondary text-4xl mb-4"></i>
                        <h3 class="text-xl font-bold text-dark mb-2">Giá Cả Cạnh Tranh</h3>
                        <p class="text-gray-600">
                            Đảm bảo giá tốt nhất thị trường với các chương trình khuyến mãi hấp dẫn.
                        </p>
                    </div>
                    <div class="feature-card bg-white rounded-xl shadow-md p-8 text-center">
                        <i class="fas fa-headset text-secondary text-4xl mb-4"></i>
                        <h3 class="text-xl font-bold text-dark mb-2">Hỗ Trợ 24/7</h3>
                        <p class="text-gray-600">
                            Đội ngũ tư vấn viên tận tâm sẵn sàng hỗ trợ khách hàng mọi lúc, mọi nơi.
                        </p>
                    </div>
                </div>
            </div>
        </section>
    </div>
</section>

<!-- Team Section -->
<section class="py-16 bg-white">
    <div class="container mx-auto px-4">
        <div class="text-center mb-12">
            <h2 class="text-3xl font-bold text-dark mb-4">Đội Ngũ Chuyên Gia</h2>
            <p class="text-gray-600 max-w-2xl mx-auto">
                Gặp gỡ những chuyên gia hàng đầu trong lĩnh vực bất động sản của chúng tôi.
            </p>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
            <div class="team-member bg-light rounded-xl p-6 text-center shadow-md transition">
                <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80" alt="Team Member" class="w-32 h-32 rounded-full mx-auto mb-4 object-cover">
                <h3 class="text-xl font-bold text-dark mb-1">Nguyễn Văn An</h3>
                <p class="text-secondary mb-3">Giám Đốc Kinh Doanh</p>
                <p class="text-gray-600 text-sm">
                    Hơn 15 năm kinh nghiệm trong lĩnh vực bất động sản cao cấp.
                </p>
            </div>
            <div class="team-member bg-light rounded-xl p-6 text-center shadow-md transition">
                <img src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=688&q=80" alt="Team Member" class="w-32 h-32 rounded-full mx-auto mb-4 object-cover">
                <h3 class="text-xl font-bold text-dark mb-1">Trần Thị Mai</h3>
                <p class="text-secondary mb-3">Quản Lý Marketing</p>
                <p class="text-gray-600 text-sm">
                    Chuyên về marketing bất động sản và truyền thông thương hiệu.
                </p>
            </div>
            <div class="team-member bg-light rounded-xl p-6 text-center shadow-md transition">
                <img src="https://images.unsplash.com/photo-1560250097-0b93528c311a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80" alt="Team Member" class="w-32 h-32 rounded-full mx-auto mb-4 object-cover">
                <h3 class="text-xl font-bold text-dark mb-1">Lê Minh Đức</h3>
                <p class="text-secondary mb-3">Chuyên Viên Tư Vấn</p>
                <p class="text-gray-600 text-sm">
                    Tư vấn khách hàng mua bán, cho thuê bất động sản tại Hà Nội.
                </p>
            </div>
            <div class="team-member bg-light rounded-xl p-6 text-center shadow-md transition">
                <img src="https://images.unsplash.com/photo-1551836022-d5d88e9218df?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80" alt="Team Member" class="w-32 h-32 rounded-full mx-auto mb-4 object-cover">
                <h3 class="text-xl font-bold text-dark mb-1">Phạm Thu Hà</h3>
                <p class="text-secondary mb-3">Quản Lý Khách Hàng</p>
                <p class="text-gray-600 text-sm">
                    Đảm bảo sự hài lòng và chăm sóc khách hàng sau bán hàng.
                </p>
            </div>
        </div>
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

