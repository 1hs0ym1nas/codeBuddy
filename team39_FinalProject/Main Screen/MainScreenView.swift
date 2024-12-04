import UIKit

class MainScreenView: UIView {

    var labelWelcome: UILabel!
    var labelPopularStudyList: UILabel!
    var button1: UIButton!
    var button2: UIButton!
    var labelRecommendForYouList: UILabel!
    var button3: UIButton!
    var button4: UIButton!
    var button5: UIButton!

    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelWelcome()
        setupLabelPopularStudyList()
        setupbutton1()
        setupbutton2()
        setupLabelRecommendForYouList()
        setupbutton3()
        setupbutton4()
        setupButton5()
        initConstraints()
    }
    
    func setupLabelWelcome(){
        labelWelcome = UILabel()
        labelWelcome.text = "Welcome"
        labelWelcome.font = .boldSystemFont(ofSize: 32)
        labelWelcome.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelWelcome)
    }
    
    func setupLabelPopularStudyList(){
        labelPopularStudyList = UILabel()
        labelPopularStudyList.font = .boldSystemFont(ofSize: 20)
        labelPopularStudyList.text = "Popular Study Lists"
        labelPopularStudyList.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPopularStudyList)
        
    }
    
    func setupbutton1(){
        button1 = UIButton(type: .system)
        // Create the original image
        var image = UIImage(systemName: "1.circle")?.withRenderingMode(.alwaysOriginal)
            
        // Resize the image by applying a larger symbol configuration
        let config = UIImage.SymbolConfiguration(pointSize: 100, weight: .regular, scale: .large)
        image = image?.withConfiguration(config)

        // Create a button configuration
        var buttonConfig = UIButton.Configuration.filled()
            
        // Set the image and title for the button
        buttonConfig.image = image
        buttonConfig.title = "Array & String"
            
        // Set the layout of the image and title
        buttonConfig.imagePlacement = .top       // Places the image at the top
        buttonConfig.imagePadding = 20            // Space between image and title
        buttonConfig.titlePadding = 8            // Optional: adds padding around the title
            
        // Set the button background color to white
        buttonConfig.background = UIBackgroundConfiguration.clear() // Transparent background
        buttonConfig.background.backgroundColor = .white  // Set the background color to white
        
        // Set the title color using attributedTitle
        buttonConfig.attributedTitle = AttributedString("Array & String", attributes: .init([.foregroundColor: UIColor.black]))
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 100, weight: .regular, scale: .large).applying(UIImage.SymbolConfiguration(weight: .regular))
        let blackImage = UIImage(systemName: "1.circle")?.withConfiguration(imageConfig).withTintColor(.black, renderingMode: .alwaysOriginal)

        buttonConfig.image = blackImage
         
        // Apply the configuration to the button
        button1.configuration = buttonConfig
            
        // Customize the title font (if needed)
        button1.titleLabel?.font = .boldSystemFont(ofSize: 20)
            
        // Ensure the content is centered
        button1.contentHorizontalAlignment = .center
        button1.contentVerticalAlignment = .center

        button1.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button1)
        
    }
    
    func setupbutton2(){
        button2 = UIButton(type: .system)
        // Create the original image
        var image = UIImage(systemName: "2.circle")?.withRenderingMode(.alwaysOriginal)
            
        // Resize the image by applying a larger symbol configuration
        let config = UIImage.SymbolConfiguration(pointSize: 100, weight: .regular, scale: .large)
        image = image?.withConfiguration(config)

        // Create a button configuration
        var buttonConfig = UIButton.Configuration.filled()
            
        // Set the image and title for the button
        buttonConfig.image = image
        buttonConfig.title = "Sliding windows & Two pointers"
            
        // Set the layout of the image and title
        buttonConfig.imagePlacement = .top       // Places the image at the top
        buttonConfig.imagePadding = 20            // Space between image and title
        buttonConfig.titlePadding = 8            // Optional: adds padding around the title
            
        // Set the button background color to white
        buttonConfig.background = UIBackgroundConfiguration.clear() // Transparent background
        buttonConfig.background.backgroundColor = .white  // Set the background color to white
        
        // Set the title color using attributedTitle
        buttonConfig.attributedTitle = AttributedString("Sliding windows & Two pointers", attributes: .init([.foregroundColor: UIColor.black]))
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 100, weight: .regular, scale: .large).applying(UIImage.SymbolConfiguration(weight: .regular))
        let blackImage = UIImage(systemName: "2.circle")?.withConfiguration(imageConfig).withTintColor(.black, renderingMode: .alwaysOriginal)

        buttonConfig.image = blackImage
         
        // Apply the configuration to the button
        button2.configuration = buttonConfig
        
        button2.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button2.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button2)
        
    }
    
    func setupLabelRecommendForYouList(){
        labelRecommendForYouList = UILabel()
        labelRecommendForYouList.font = .boldSystemFont(ofSize: 20)
        labelRecommendForYouList.text = "Recommend For You"
        labelRecommendForYouList.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelRecommendForYouList)
        
    }
    
    func setupbutton3(){
        button3 = UIButton(type: .system)
        // Create the original image
        var image = UIImage(systemName: "3.circle")?.withRenderingMode(.alwaysOriginal)
            
        // Resize the image by applying a larger symbol configuration
        let config = UIImage.SymbolConfiguration(pointSize: 55, weight: .regular, scale: .large)
        image = image?.withConfiguration(config)

        // Create a button configuration
        var buttonConfig = UIButton.Configuration.filled()
            
        // Set the image and title for the button
        buttonConfig.image = image
        buttonConfig.title = "Tree & Recursion"
            
        // Set the layout of the image and title
        buttonConfig.imagePlacement = .top       // Places the image at the top
        buttonConfig.imagePadding = 20            // Space between image and title
        buttonConfig.titlePadding = 8            // Optional: adds padding around the title
            
        // Set the button background color to white
        buttonConfig.background = UIBackgroundConfiguration.clear() // Transparent background
        buttonConfig.background.backgroundColor = .white  // Set the background color to white
        
        // Set the title color using attributedTitle
        buttonConfig.attributedTitle = AttributedString("Tree & Recursion", attributes: .init([.foregroundColor: UIColor.black]))
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 55, weight: .regular, scale: .large).applying(UIImage.SymbolConfiguration(weight: .regular))
        let blackImage = UIImage(systemName: "3.circle")?.withConfiguration(imageConfig).withTintColor(.black, renderingMode: .alwaysOriginal)

        buttonConfig.image = blackImage
         
        // Apply the configuration to the button
        button3.configuration = buttonConfig
            
        // Customize the title font (if needed)
        button3.titleLabel?.font = .boldSystemFont(ofSize: 20)
            
        // Ensure the content is centered
        button3.contentHorizontalAlignment = .center
        button3.contentVerticalAlignment = .center
        button3.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button3)
        
    }
    
    func setupbutton4(){
        button4 = UIButton(type: .system)
        // Create the original image
        var image = UIImage(systemName: "4.circle")?.withRenderingMode(.alwaysOriginal)
            
        // Resize the image by applying a larger symbol configuration
        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .regular, scale: .large)
        image = image?.withConfiguration(config)

        // Create a button configuration
        var buttonConfig = UIButton.Configuration.filled()
            
        // Set the image and title for the button
        buttonConfig.image = image
        buttonConfig.title = "Math & Hash table"
            
        // Set the layout of the image and title
        buttonConfig.imagePlacement = .top       // Places the image at the top
        buttonConfig.imagePadding = 20            // Space between image and title
        buttonConfig.titlePadding = 8            // Optional: adds padding around the title
            
        // Set the button background color to white
        buttonConfig.background = UIBackgroundConfiguration.clear() // Transparent background
        buttonConfig.background.backgroundColor = .white  // Set the background color to white
        
        // Set the title color using attributedTitle
        buttonConfig.attributedTitle = AttributedString("Math & Hash table", attributes: .init([.foregroundColor: UIColor.black]))
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .regular, scale: .large).applying(UIImage.SymbolConfiguration(weight: .regular))
        let blackImage = UIImage(systemName: "4.circle")?.withConfiguration(imageConfig).withTintColor(.black, renderingMode: .alwaysOriginal)

        buttonConfig.image = blackImage
         
        // Apply the configuration to the button
        button4.configuration = buttonConfig
            
        // Customize the title font (if needed)
        button4.titleLabel?.font = .boldSystemFont(ofSize: 20)
            
        // Ensure the content is centered
        button4.contentHorizontalAlignment = .center
        button4.contentVerticalAlignment = .center
        button4.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button4)
        
    }
    
    func setupButton5(){
        button5 = UIButton(type: .system)
        // Create the original image
        var image = UIImage(systemName: "5.circle")?.withRenderingMode(.alwaysOriginal)
            
        // Resize the image by applying a larger symbol configuration
        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .regular, scale: .large)
        image = image?.withConfiguration(config)

        // Create a button configuration
        var buttonConfig = UIButton.Configuration.filled()
            
        // Set the image and title for the button
        buttonConfig.image = image
        buttonConfig.title = "Stack & Queue"
            
        // Set the layout of the image and title
        buttonConfig.imagePlacement = .top       // Places the image at the top
        buttonConfig.imagePadding = 20            // Space between image and title
        buttonConfig.titlePadding = 8            // Optional: adds padding around the title
            
        // Set the button background color to white
        buttonConfig.background = UIBackgroundConfiguration.clear() // Transparent background
        buttonConfig.background.backgroundColor = .white  // Set the background color to white
        
        // Set the title color using attributedTitle
        buttonConfig.attributedTitle = AttributedString("Stack & Queue", attributes: .init([.foregroundColor: UIColor.black]))
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .regular, scale: .large).applying(UIImage.SymbolConfiguration(weight: .regular))
        let blackImage = UIImage(systemName: "5.circle")?.withConfiguration(imageConfig).withTintColor(.black, renderingMode: .alwaysOriginal)

        buttonConfig.image = blackImage
         
        // Apply the configuration to the button
        button5.configuration = buttonConfig
            
        // Customize the title font (if needed)
        button5.titleLabel?.font = .boldSystemFont(ofSize: 20)
            
        // Ensure the content is centered
        button5.contentHorizontalAlignment = .center
        button5.contentVerticalAlignment = .center

        button5.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button5)
        
    }
    
    func initConstraints(){
        
        // Ensure to add the stackView after its initialization
        let stackView = UIStackView(arrangedSubviews: [button3, button4, button5])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually // Distribute buttons equally within the stack
        stackView.spacing = 16 // Space between buttons
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView) // Add stackView to the view
        
        NSLayoutConstraint.activate([
            labelWelcome.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            labelWelcome.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            labelPopularStudyList.topAnchor.constraint(equalTo: self.labelWelcome.bottomAnchor, constant: 16),
            labelPopularStudyList.leadingAnchor.constraint(equalTo: self.labelWelcome.leadingAnchor),
            
            button1.topAnchor.constraint(equalTo: self.labelPopularStudyList.bottomAnchor, constant: 16),
            button1.leadingAnchor.constraint(equalTo: self.labelWelcome.leadingAnchor),
            button1.heightAnchor.constraint(equalToConstant: 200),
            button1.widthAnchor.constraint(equalToConstant: 200),
            
            button2.topAnchor.constraint(equalTo: self.button1.topAnchor),
            button2.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            button2.heightAnchor.constraint(equalTo:self.button1.heightAnchor),
            button2.widthAnchor.constraint(equalTo:self.button1.widthAnchor),
            
            //button1.trailingAnchor.constraint(equalTo: self.button2.leadingAnchor, constant: -16),
            
            labelRecommendForYouList.topAnchor.constraint(equalTo: self.button1.bottomAnchor, constant: 16),
            labelRecommendForYouList.leadingAnchor.constraint(equalTo: self.labelWelcome.leadingAnchor),
            
            
            // Stack View Constraints for button3, button4, button5
            stackView.topAnchor.constraint(equalTo: self.labelRecommendForYouList.bottomAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 60), // Height for all buttons
            stackView.widthAnchor.constraint(equalToConstant: 80) // Height for all buttons

        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

