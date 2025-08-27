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
      <h2 class="text-3xl font-bold text-dark mb-4">
        Bất Động Sản Nổi Bật
      </h2>
      <p class="text-gray-600 max-w-2xl mx-auto">
        Khám phá những bất động sản được lựa chọn kỹ lưỡng dành cho thuê và
        bán
      </p>
    </div>
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
      <!-- Property Card 1 -->
      <div
              class="property-card bg-white rounded-xl overflow-hidden shadow-md transition"
      >
        <div class="relative">
          <img
                  src="https://plus.unsplash.com/premium_photo-1661340695541-ee1ca7efedd0?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8YnVpbGRpbmd8ZW58MHx8MHx8fDA%3D"
                  alt="Tòa Nhà Hiện Đại Giữa Trung Tâm"
                  class="w-full h-60 object-cover"
          />
          <div
                  class="absolute top-4 right-4 bg-secondary text-white px-3 py-1 rounded-full text-sm font-bold"
          >
            For Rent
          </div>
          <div
                  class="absolute bottom-4 left-4 bg-white px-3 py-1 rounded-full text-sm font-bold"
          >
            $1,250,000/year
          </div>
        </div>
        <div class="p-6">
          <h3 class="text-xl font-bold text-dark mb-2">
            Tòa Nhà Hiện Đại Giữa Trung Tâm
          </h3>
          <p class="text-gray-600 mb-4">
            <i class="fas fa-map-marker-alt text-secondary mr-2"></i>Kim Mã,
            Ba Đình
          </p>
          <div class="flex justify-between border-t border-gray-200 pt-4">
            <div class="flex items-center">
              <i class="fas fa-bed text-gray-500 mr-1"></i>
              <span class="text-gray-700">40 Tầng</span>
            </div>
            <div class="flex items-center">
              <i class="fas fa-bath text-gray-500 mr-1"></i>
              <span class="text-gray-700">6 thang máy</span>
            </div>
            <div class="flex items-center">
              <i class="fas fa-ruler-combined text-gray-500 mr-1"></i>
              <span class="text-gray-700">3,200 sqft</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Property Card 2 -->
      <div
              class="property-card bg-white rounded-xl overflow-hidden shadow-md transition"
      >
        <div class="relative">
          <img
                  src="https://plus.unsplash.com/premium_photo-1674676471417-07f613528a94?q=80&w=1145&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                  alt="Modern Apartment"
                  class="w-full h-60 object-cover"
          />
          <div
                  class="absolute top-4 right-4 bg-primary text-white px-3 py-1 rounded-full text-sm font-bold"
          >
            For Rent
          </div>
          <div
                  class="absolute bottom-4 left-4 bg-white px-3 py-1 rounded-full text-sm font-bold"
          >
            $2,400/mo
          </div>
        </div>
        <div class="p-6">
          <h3 class="text-xl font-bold text-dark mb-2">
            Căn Hộ Tiện Nghi, Gần Trung Tâm
          </h3>
          <p class="text-gray-600 mb-4">
            <i class="fas fa-map-marker-alt text-secondary mr-2"></i>Tây Hồ,
            HN
          </p>
          <div class="flex justify-between border-t border-gray-200 pt-4">
            <div class="flex items-center">
              <i class="fas fa-bed text-gray-500 mr-1"></i>
              <span class="text-gray-700">2 Beds</span>
            </div>
            <div class="flex items-center">
              <i class="fas fa-bath text-gray-500 mr-1"></i>
              <span class="text-gray-700">2 Baths</span>
            </div>
            <div class="flex items-center">
              <i class="fas fa-ruler-combined text-gray-500 mr-1"></i>
              <span class="text-gray-700">1,200 sqft</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Property Card 3 -->
      <div
              class="property-card bg-white rounded-xl overflow-hidden shadow-md transition"
      >
        <div class="relative">
          <img
                  src="https://images.unsplash.com/photo-1631193816258-28b44b21e78b?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8b2ZmaWNlJTIwc3BhY2V8ZW58MHx8MHx8fDA%3D"
                  alt="Office Building"
                  class="w-full h-60 object-cover"
          />
          <div
                  class="absolute top-4 right-4 bg-green-600 text-white px-3 py-1 rounded-full text-sm font-bold"
          >
            For Lease
          </div>
          <div
                  class="absolute bottom-4 left-4 bg-white px-3 py-1 rounded-full text-sm font-bold"
          >
            $8,500/mo
          </div>
        </div>
        <div class="p-6">
          <h3 class="text-xl font-bold text-dark mb-2">
            Văn phòng cao cấp do doanh nghiệp
          </h3>
          <p class="text-gray-600 mb-4">
            <i class="fas fa-map-marker-alt text-secondary mr-2"></i
            >Chicago, IL
          </p>
          <div class="flex justify-between border-t border-gray-200 pt-4">
            <div class="flex items-center">
              <i class="fas fa-building text-gray-500 mr-1"></i>
              <span class="text-gray-700">5 Floors</span>
            </div>
            <div class="flex items-center">
              <i class="fas fa-parking text-gray-500 mr-1"></i>
              <span class="text-gray-700">50 Spaces</span>
            </div>
            <div class="flex items-center">
              <i class="fas fa-ruler-combined text-gray-500 mr-1"></i>
              <span class="text-gray-700">25,000 sqft</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="text-center mt-12">
      <button
              class="bg-primary hover:bg-blue-800 text-white px-8 py-3 rounded-lg font-medium transition"
      >
        View All Properties
      </button>
    </div>
  </div>
</section>

<!-- Categories Section -->
<section class="py-16 bg-white">
  <div class="container mx-auto px-4">
    <div class="text-center mb-12">
      <h2 class="text-3xl font-bold text-dark mb-4">
        Danh Mục Bất Động Sản
      </h2>
      <p class="text-gray-600 max-w-2xl mx-auto">
        Khám phá các loại bất động sản đa dạng để tìm loại phù hợp với nhu
        cầu của bạn
      </p>
    </div>

    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
      <div class="category-card bg-blue-50 rounded-xl p-8 text-center">
        <div
                class="w-16 h-16 bg-primary rounded-full flex items-center justify-center mx-auto mb-6"
        >
          <i class="fas fa-building text-white text-2xl"></i>
        </div>
        <h3 class="text-xl font-bold text-dark mb-2">Căn Hộ</h3>
        <p class="text-gray-600">
          Các căn hộ hiện đại tại vị trí trung tâm.
        </p>
      </div>
      <div class="category-card bg-blue-50 rounded-xl p-8 text-center">
        <div
                class="w-16 h-16 bg-primary rounded-full flex items-center justify-center mx-auto mb-6"
        >
          <i class="fas fa-house-chimney text-white text-2xl"></i>
        </div>
        <h3 class="text-xl font-bold text-dark mb-2">Nhà Ở</h3>
        <p class="text-gray-600">Những ngôi nhà ấm cúng cho gia đình.</p>
      </div>
      <div class="category-card bg-blue-50 rounded-xl p-8 text-center">
        <div
                class="w-16 h-16 bg-primary rounded-full flex items-center justify-center mx-auto mb-6"
        >
          <i class="fas fa-briefcase text-white text-2xl"></i>
        </div>
        <h3 class="text-xl font-bold text-dark mb-2">Văn Phòng</h3>
        <p class="text-gray-600">
          Không gian làm việc hiện đại và tiện nghi.
        </p>
      </div>
      <div class="category-card bg-blue-50 rounded-xl p-8 text-center">
        <div
                class="w-16 h-16 bg-primary rounded-full flex items-center justify-center mx-auto mb-6"
        >
          <i class="fas fa-store text-white text-2xl"></i>
        </div>
        <h3 class="text-xl font-bold text-dark mb-2">Thương Mại</h3>
        <p class="text-gray-600">
          Cửa hàng và mặt bằng kinh doanh đắc địa.
        </p>
      </div>
    </div>
  </div>
</section>

<!-- Services Section -->
<section class="py-16 bg-light">
  <div class="container mx-auto px-4">
    <div class="text-center mb-12">
      <h2 class="text-3xl font-bold text-dark mb-4">
        Dịch Vụ Của Chúng Tôi
      </h2>
      <p class="text-gray-600 max-w-2xl mx-auto">
        Chúng tôi cung cấp dịch vụ chuyên nghiệp từ tư vấn đến quản lý bất
        động sản
      </p>
    </div>

    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
      <div
              class="feature-card bg-white rounded-xl shadow-md p-8 text-center"
      >
        <i class="fas fa-handshake text-secondary text-4xl mb-4"></i>
        <h3 class="text-xl font-bold text-dark mb-2">Tư Vấn</h3>
        <p class="text-gray-600">
          Hướng dẫn chọn lựa bất động sản phù hợp với nhu cầu.
        </p>
      </div>
      <div
              class="feature-card bg-white rounded-xl shadow-md p-8 text-center"
      >
        <i class="fas fa-key text-secondary text-4xl mb-4"></i>
        <h3 class="text-xl font-bold text-dark mb-2">Cho Thuê</h3>
        <p class="text-gray-600">
          Hỗ trợ cho thuê bất động sản nhanh chóng.
        </p>
      </div>
      <div
              class="feature-card bg-white rounded-xl shadow-md p-8 text-center"
      >
        <i class="fas fa-cogs text-secondary text-4xl mb-4"></i>
        <h3 class="text-xl font-bold text-dark mb-2">Quản Lý</h3>
        <p class="text-gray-600">
          Quản lý tài sản, hợp đồng và khách hàng chuyên nghiệp.
        </p>
      </div>
    </div>
  </div>
</section>

<!-- Testimonials Section -->
<section class="py-16 bg-white">
  <div class="container mx-auto px-4">
    <div class="text-center mb-12">
      <h2 class="text-3xl font-bold text-dark mb-4">Khách Hàng Nói Gì</h2>
      <p class="text-gray-600 max-w-2xl mx-auto">
        Cảm nhận của khách hàng về dịch vụ chuyên nghiệp và đáng tin cậy của
        chúng tôi
      </p>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
      <div
              class="testimonial-card bg-light rounded-xl shadow-md p-6 text-center"
      >
        <p class="text-gray-600 mb-4">
          "PrimeProperties giúp tôi tìm được căn hộ ưng ý ngay trong trung
          tâm thành phố!"
        </p>
        <h4 class="font-bold text-dark">Nguyễn Văn A</h4>
        <span class="text-gray-500 text-sm">Khách Hàng</span>
      </div>
      <div
              class="testimonial-card bg-light rounded-xl shadow-md p-6 text-center"
      >
        <p class="text-gray-600 mb-4">
          "Dịch vụ tư vấn nhiệt tình và chuyên nghiệp, tôi hoàn toàn yên
          tâm."
        </p>
        <h4 class="font-bold text-dark">Trần Thị B</h4>
        <span class="text-gray-500 text-sm">Khách Hàng</span>
      </div>
      <div
              class="testimonial-card bg-light rounded-xl shadow-md p-6 text-center"
      >
        <p class="text-gray-600 mb-4">
          "Quản lý hợp đồng và giao dịch nhanh chóng, rất hài lòng với
          PrimeProperties."
        </p>
        <h4 class="font-bold text-dark">Lê Văn C</h4>
        <span class="text-gray-500 text-sm">Khách Hàng</span>
      </div>
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

