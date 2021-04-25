//
//  TermsConditionsView.swift
//  Borrow
//
//  Created by Casey on 2/7/21.
//

import SwiftUI

struct TermsConditionsView: View {
    
    @Binding var checked: Bool
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            VStack {
                Image("BorrowAppLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350.0, height: 150.0)
                    .padding(.top, -100)
                
                VStack (alignment: .center){
                    Text("Terms and Conditions")
                        .font(.title)
                    
                    ScrollView {
                        Text("Some really long statement of text that users probably won't read unless they want their money back for some make money quick scheme to sue the company that we missed a word on our policy and user standard agreement that they agreed to but want to find a catch, kind of like the gorilla glue girl that is making a lawsuit against the company that they never said not to use their products on hair even though they state not to have it contact skin or near eyes, etc. So with it being bike renting, should probably have some kind of terms of agreements here for safety too. Users will scroll through this really quicky then just check that they give consent. This should also probably include things like that the user using this app agrees to follow safety guidelines when borrowing bikes and meeting up with strangers to acquire said bikes. Policy should also include some text regarding loss, theft, damange, or replacement procedures and how the user will be liable for the listing loss price of item. Maybe in the future there will have to be some kind of claims option in the app, maybe in the my account section where users can provide proof of loss (such as a police report looking for the borrowed item) or damage where they can submit pictures. I'm not sure since I don't know legal policies and normally I am that user that also doesn't read the application policy and just checks the box that I agree to the terms and conditions                                                                   ")
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(nil)
                        
                    }.frame(width: 345, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .border(Color.gray)
                    
                }.padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                //Scroll text area helpful source: https://stackoverflow.com/questions/56593120/how-do-you-create-a-multi-line-text-inside-a-scrollview-in-swiftui
                VStack{
                    //checkbox
                    HStack{
                    Image(systemName: checked ? "checkmark.square.fill" : "square")
                        .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
                        .onTapGesture {
                            self.checked.toggle()
                        }
                    Text("I have read and accept the terms and conditions.")
                    }
                    Spacer(minLength: 20)
                    Button(action: {
                        //TODO: Progress to default map screen
                    }, label: { Text("   Continue   ")
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(20) })
                    
                }
            }
        }
    }
}

struct TermsConditionsView_Previews: PreviewProvider {
    struct CheckBoxViewHolder: View {
        @State var checked = false
        
        var body: some View {
            TermsConditionsView(checked: $checked)
        }
    }
    
    static var previews: some View {
        CheckBoxViewHolder()
    }
}
