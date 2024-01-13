//
//  TaskRowView.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/9.
//

import SwiftUI


struct TaskRowView: View {
    public let task: Task

    var body: some View {
        HStack {
            Image(task.icon)
                .resizable()
                .frame(width: 60, height: 60)
                .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))

            VStack(alignment: .leading, content: {
                Text(LocalizedStringKey(task.name))
                    .font(.headline)
                    .bold()

                HStack {
                    if ((task.site) != nil) {
                        Image("site")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    
                    if ((task.code) != nil) {
                        Image("code")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
            })
            Spacer()
        }
        .padding(EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10))
        .background(.gray)
        .shadow(radius: 12)
    }
}

struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        TaskRowView(task: Task(
            name: "Official Bridge",
            icon: "optimism",
            site: "http://baidu.com",
            code:  "codeKey"
        ))
        
        TaskRowView(task: Task(
            name: "Official Bridge",
            icon: "optimism",
            site: "http://baidu.com",
            code: nil
        ))
    }
}
