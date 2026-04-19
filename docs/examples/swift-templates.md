# Swift 代码示例

> AI 编程常用的 Swift 代码模板

## 🏗 MVVM 架构模板

### Model

```swift
import Foundation
import SwiftData

@Model
final class User {
    var id: UUID
    var name: String
    var email: String
    var createdAt: Date
    var updatedAt: Date
    
    init(name: String, email: String) {
        self.id = UUID()
        self.name = name
        self.email = email
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}
```

### ViewModel

```swift
import Foundation
import SwiftData

@Observable
class UserListViewModel {
    // MARK: - Properties
    var users: [User] = []
    var isLoading = false
    var errorMessage: String?
    
    // MARK: - Dependencies
    private let modelContext: ModelContext
    
    // MARK: - Initialization
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Public Methods
    
    /// 加载用户列表
    @MainActor
    func loadUsers() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let descriptor = FetchDescriptor<User>(
                sortBy: [SortDescriptor(\User.createdAt, order: .reverse)]
            )
            users = try modelContext.fetch(descriptor)
        } catch {
            errorMessage = "加载失败: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    /// 添加用户
    @MainActor
    func addUser(name: String, email: String) {
        let user = User(name: name, email: email)
        modelContext.insert(user)
        users.append(user)
    }
    
    /// 删除用户
    func deleteUser(_ user: User) {
        modelContext.delete(user)
        users.removeAll { $0.id == user.id }
    }
}
```

### View

```swift
import SwiftUI

struct UserListView: View {
    // MARK: - Properties
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: UserListViewModel
    
    // MARK: - Initialization
    init() {
        // ViewModel will be initialized in task
        _viewModel = State(initialValue: UserListViewModel(modelContext: ModelContext(.init())))
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("加载中...")
                } else if viewModel.users.isEmpty {
                    ContentUnavailableView(
                        "暂无用户",
                        systemImage: "person.2.slash",
                        description: Text("点击右上角添加用户")
                    )
                } else {
                    userListView
                }
            }
            .navigationTitle("用户列表")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    addButton
                }
            }
            .task {
                viewModel = UserListViewModel(modelContext: modelContext)
                await viewModel.loadUsers()
            }
            .alert("错误", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("确定") {
                    viewModel.errorMessage = nil
                }
            } message: {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
    }
    
    // MARK: - Subviews
    
    private var userListView: some View {
        List {
            ForEach(viewModel.users) { user in
                UserRowView(user: user)
                    .swipeActions(edge: .trailing) {
                        deleteButton(for: user)
                    }
            }
        }
    }
    
    private var addButton: some View {
        Button(action: { /* 显示添加界面 */ }) {
            Image(systemName: "plus")
        }
    }
    
    private func deleteButton(for user: User) -> some View {
        Button(role: .destructive) {
            viewModel.deleteUser(user)
        } label: {
            Label("删除", systemImage: "trash")
        }
    }
}

// MARK: - Preview
#Preview {
    UserListView()
        .modelContainer(for: User.self, inMemory: true)
}
```

---

## 🌐 网络请求模板

### NetworkManager

```swift
import Foundation

/// 网络错误
enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError(Error)
    case noData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "无效的 URL"
        case .invalidResponse:
            return "无效的响应"
        case .httpError(let statusCode):
            return "HTTP 错误: \(statusCode)"
        case .decodingError(let error):
            return "解码错误: \(error.localizedDescription)"
        case .noData:
            return "无数据"
        }
    }
}

/// 网络管理器
actor NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = URL(string: "https://api.example.com")!
    private let session: URLSession
    private let decoder: JSONDecoder
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        self.session = URLSession(configuration: config)
        
        self.decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    /// GET 请求
    func get<T: Codable>(_ endpoint: String) async throws -> T {
        let url = baseURL.appendingPathComponent(endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    /// POST 请求
    func post<T: Codable, U: Encodable>(_ endpoint: String, body: U) async throws -> T {
        let url = baseURL.appendingPathComponent(endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        request.httpBody = try encoder.encode(body)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
```

---

## 💾 数据持久化模板

### SwiftData Model

```swift
import Foundation
import SwiftData

@Model
final class TodoItem {
    // MARK: - Properties
    @Attribute(.unique) var id: UUID
    var title: String
    var detail: String?
    var isCompleted: Bool
    var priority: Priority
    var category: Category?
    var createdAt: Date
    var updatedAt: Date
    var reminderDate: Date?
    
    // MARK: - Relationships
    @Relationship(deleteRule: .cascade)
    var subtasks: [Subtask] = []
    
    // MARK: - Enums
    enum Priority: Int, Codable, CaseIterable {
        case low = 1
        case medium = 2
        case high = 3
        
        var displayName: String {
            switch self {
            case .low: return "低"
            case .medium: return "中"
            case .high: return "高"
            }
        }
    }
    
    // MARK: - Initialization
    init(
        title: String,
        detail: String? = nil,
        priority: Priority = .medium,
        category: Category? = nil
    ) {
        self.id = UUID()
        self.title = title
        self.detail = detail
        self.isCompleted = false
        self.priority = priority
        self.category = category
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}

@Model
final class Category {
    @Attribute(.unique) var id: UUID
    var name: String
    var color: String
    var iconName: String
    
    init(name: String, color: String, iconName: String) {
        self.id = UUID()
        self.name = name
        self.color = color
        self.iconName = iconName
    }
}

@Model
final class Subtask {
    @Attribute(.unique) var id: UUID
    var title: String
    var isCompleted: Bool
    
    init(title: String) {
        self.id = UUID()
        self.title = title
        self.isCompleted = false
    }
}
```

---

## 🎨 常用组件模板

### 加载视图

```swift
import SwiftUI

struct LoadingView: View {
    var message: String = "加载中..."
    
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            
            Text(message)
                .font(.headline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoadingView()
}
```

### 空状态视图

```swift
import SwiftUI

struct EmptyStateView: View {
    let title: String
    let systemImage: String
    let description: String?
    let action: (() -> Void)?
    
    init(
        title: String,
        systemImage: String,
        description: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.systemImage = systemImage
        self.description = description
        self.action = action
    }
    
    var body: some View {
        ContentUnavailableView {
            Label(title, systemImage: systemImage)
        } description: {
            if let description {
                Text(description)
            }
        } actions: {
            if let action {
                Button(action: action) {
                    Text("添加")
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    EmptyStateView(
        title: "暂无数据",
        systemImage: "tray",
        description: "点击下方按钮添加数据"
    ) {
        print("添加数据")
    }
}
```

### 错误视图

```swift
import SwiftUI

struct ErrorView: View {
    let error: Error
    let retryAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 60))
                .foregroundStyle(.red)
            
            Text("出错了")
                .font(.headline)
            
            Text(error.localizedDescription)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            
            if let retryAction {
                Button("重试", action: retryAction)
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}

#Preview {
    ErrorView(
        error: NetworkError.httpError(statusCode: 404),
        retryAction: { print("重试") }
    )
}
```

---

## 🧪 测试模板

### 单元测试

```swift
import XCTest
@testable import MyProject

final class UserListViewModelTests: XCTestCase {
    var sut: UserListViewModel!
    var modelContext: ModelContext!
    
    override func setUp() {
        super.setUp()
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: User.self, configurations: config)
        modelContext = container.mainContext
        sut = UserListViewModel(modelContext: modelContext)
    }
    
    override func tearDown() {
        sut = nil
        modelContext = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testInitialState() {
        XCTAssertTrue(sut.users.isEmpty)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.errorMessage)
    }
    
    func testAddUser() async {
        // Given
        let initialCount = sut.users.count
        
        // When
        sut.addUser(name: "Test User", email: "test@example.com")
        
        // Then
        XCTAssertEqual(sut.users.count, initialCount + 1)
        XCTAssertEqual(sut.users.last?.name, "Test User")
    }
    
    func testDeleteUser() async {
        // Given
        sut.addUser(name: "Test User", email: "test@example.com")
        let user = sut.users.first!
        let initialCount = sut.users.count
        
        // When
        sut.deleteUser(user)
        
        // Then
        XCTAssertEqual(sut.users.count, initialCount - 1)
    }
}
```

---

**这些代码模板可直接使用或根据需要修改。**
