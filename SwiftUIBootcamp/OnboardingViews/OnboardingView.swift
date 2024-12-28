//
//  Onboarding.swift
//  SwiftUIBootcamp
//
//  Created by Ricky Mafra Moino on 20/12/24.
//

import SwiftUI

struct OnboardingView: View {
    // Steps:
    // 0 - Landing (signin or signup)
    // 1 - Signup Form
    // 2 - Manual or Integration
    @State var step: Int = 2
    
    @AppStorage("user_name") var currentUsername: String = ""
    @AppStorage("amount") var currentAmount: Double?
    @AppStorage("manual") var currentManual: Bool?
    @AppStorage("is_signed") var currentIsSigned: Bool = false
    
    @State var name: String = ""
    @State var amount: Double? = nil
    @State var membersAmount: Int = 1
    @State var manual: Bool? = nil
    @Environment(\.locale) private var locale
    
    @State var alertTitle: String = ""
    @State var isAlertVisible: Bool = false
    
    
    let stepTransition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                switch step {
                case 0:
                    landingStep
                case 1:
                    registerForm
                        .transition(stepTransition)
                case 2:
                    integrationOrManualStep
                        .transition(stepTransition)
                default:
                    RoundedRectangle(cornerRadius: 0)
                        .foregroundStyle(.green)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                }
                Spacer()
                Spacer()
            }
            
            VStack {
                Spacer()
                registerButton
            }
        }
        .padding(30)
        .alert(isPresented: $isAlertVisible) {
            Alert(title: Text(alertTitle))
        }
    }
}

#Preview {
    OnboardingView()
        .background {
            RadialGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)), Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))]),
                center: .bottomLeading,
                startRadius: UIScreen.main.bounds.height / 2,
                endRadius: UIScreen.main.bounds.height
            )
            .frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height)
            .ignoresSafeArea()
        }
}

// MARK: COMPONENTS
extension OnboardingView {
    // MARK: [View] Landing Step
    var landingStep: some View {
        VStack {
            Image(systemName: "dollarsign.gauge.chart.lefthalf.righthalf")
                .resizable()
                .frame(width: 200, height: 170)
            
            stepTitle("DuoMoney")
                .overlay {
                    Capsule()
                        .frame(height: 3)
                        .offset(y: 20)
                }
                
            Text("Welcome to **DuoMoney**! This is the **budgeting app** you and your family were looking for.")
                .font(.title3)
                .fontWeight(.medium)
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 20)
    }
    
    // MARK: [View] Register Step
    var registerForm: some View {
        VStack(alignment: .leading) {
            stepTitle("User Info")
            
            label("Name")
            TextField(
                "Name",
                text: $name,
                prompt: textFieldPlaceholder("How would you like to be called?")
            )
                .frame(height: 30)
                .padding()
                .background(Color.white.opacity(0.2), in: RoundedRectangle(cornerRadius: 6))
            
            label("Salary")
                .padding(.top)
            TextField(
                "Salary",
                value: $amount,
                format: .currency(code: locale.currency?.identifier ?? "CAD"),
                prompt: textFieldPlaceholder("What's your annual salary?")
            )
                .frame(height: 30)
                .padding()
                .background(Color.white.opacity(0.2), in: RoundedRectangle(cornerRadius: 6))
                .keyboardType(.numberPad)
            
            label("Family members")
                .padding(.top)
            Picker("Family members", selection: $membersAmount, content: {
                Text("Just me").tag(1)
                Text("2 or more").tag(2)
                Text("Big family").tag(3)
            })
                .frame(height: 30)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white.opacity(0.2), in: RoundedRectangle(cornerRadius: 6))
                .tint(.white)
        }
        .foregroundStyle(.white)
    }
    
    var integrationOrManualStep: some View {
        VStack(alignment: .leading, spacing: 20) {
            stepTitle("Pick an option:")
                .foregroundStyle(.white)
            
            optionCard(image: "keyboard", text: "Manual", isSelected: manual ?? false)
                .onTapGesture {
                    withAnimation {
                        manual = true
                    }
                }
            
            optionCard(image: "network", text: "Integrated", isSelected: manual == nil ? false : !manual!, imageHeight: 80)
                .onTapGesture {
                    withAnimation {
                        manual = false
                    }
                }
        }
    }
    
    // MARK: Register Button
    var registerButton: some View {
        Button {
            handleNextButtonPressed()
        } label: {
            Text(step == 0 ? "Signup"
                 : step == 1 ? "(1/2) Continue"
                 : "Finish")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
        }
        .buttonStyle(.borderedProminent)
        .tint(LinearGradient(
            gradient: Gradient(colors: [Color(#colorLiteral(red: 0.002203518931, green: 0.776029249, blue: 0.003418960253, alpha: 1)), Color(#colorLiteral(red: 0.001672449239, green: 0.5889985826, blue: 0.002594957272, alpha: 1))]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ))
    }
}

// MARK: COMPONENT HELPERS
extension OnboardingView {
    func textFieldPlaceholder(_ title: String) -> Text {
        Text(title)
            .foregroundStyle(Color.white.opacity(0.5))
    }
    
    func label(_ text: String) -> Text {
        Text(text)
            .font(.subheadline)
            .fontWeight(.semibold)
    }
    
    func stepTitle(_ title: String) -> some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.bottom)
    }
    
    func optionCard(
        image: String,
        text: String,
        isSelected: Bool,
        imageHeight: CGFloat? = nil,
        bgColor: Color? = nil
    ) -> some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: imageHeight)
            
            Text(text)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 12)
        }
        .foregroundStyle(.white)
        .frame(height: 200)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
    }
}

// MARK: FUNCTIONS
extension OnboardingView {
    func showAlert(title: String) {
        alertTitle = title
        isAlertVisible.toggle()
    }
    
    func handleNextButtonPressed() -> Void {
        withAnimation {
            switch step {
            case 1:
                guard name.count >= 3 else {
                    showAlert(title: "Your name must be at least 3 characters long! 😩")
                    return
                }
                
                guard amount != nil && amount! > 0 else {
                    showAlert(title: "Your salary must be higher than 0! 🤑")
                    return
                }
            case 2:
                guard manual == true || manual == false else {
                    showAlert(title: "Please select one of the options (manual or integrated)! 🙈")
                    return
                }
            default:
                break
            }
            
            if step == 2 {
                currentUsername = name
                currentAmount = amount
                currentManual = manual
                currentIsSigned = true
            } else {
                step += 1
            }
        }
    }
}
