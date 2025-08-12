//
//  Notifications.swift
//  Hydrate
//
//  Created by Fai Alharthi on 19/04/1446 AH.
//
import SwiftUI
import UserNotifications

struct Notifications: View {
    @Binding var weight: Double
    var p1: person

    let Minintervals = [15, 30, 60, 90]
    let Hourintervals = [2, 3, 4, 5]
    @State private var navigate = false
    @State private var selectedInterval: Int? = nil
    @State var StartHour: Date = Date()
    @State var EndHour: Date = Date()

    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            VStack {
                Text("Notification Preferences")
                    .font(.system(size: 22, weight: .bold))
                    .frame(width: 360, alignment: .leading)

                Text("The start and End hour")
                    .font(.system(size: 17, weight: .semibold))
                    .frame(width: 360, alignment: .leading)
                    .padding(.top, 17)

                Text("Specify the start and end date to receive the notifications")
                    .font(.system(size: 16))
                    .frame(width: 360, alignment: .leading)
                    .padding(.top, 1)
                    .foregroundStyle(Color.secondary)

                VStack {
                    ZStack {
                        Rectangle()
                            .frame(height: 44)
                            .foregroundStyle(Color.myFieldsGray)

                        Text("Start Hour")
                            .frame(width: 330, alignment: .leading)
                            .padding(.top)

                        DatePicker("", selection: $StartHour, displayedComponents: .hourAndMinute)
                            .frame(width: 320)
                            .padding(.top, 20)
                    }
                    Divider()
                    ZStack {
                        Rectangle()
                            .frame(height: 44)
                            .foregroundStyle(Color.myFieldsGray)

                        Text("End Hour")
                            .frame(width: 330, alignment: .leading)
                            .padding(.bottom)

                        DatePicker("", selection: $EndHour, displayedComponents: .hourAndMinute)
                            .frame(width: 320)
                            .padding(.bottom, 20)
                    }
                }
                .frame(width: 380, height: 110)
                .background(Color.myFieldsGray)
                .padding(.top, 20)

                Text("Notification interval")
                    .font(.system(size: 17, weight: .bold))
                    .frame(width: 360, alignment: .leading)
                    .padding(.top, 30)

                Text("How often would you like to receive notifications within the specified time interval")
                    .font(.system(size: 16))
                    .frame(width: 360, alignment: .leading)
                    .padding(.top, 1)
                    .foregroundStyle(Color.secondary)

                VStack(spacing: 20) {
                    // صف الدقائق
                    HStack(spacing: 12) {
                        ForEach(Minintervals, id: \.self) { interval in
                            Button(action: {
                                selectedInterval = interval
                            }) {
                                VStack {
                                    Text("\(interval)")
                                        .foregroundColor(selectedInterval == interval ? .white : .cyan)
                                    Text("Mins")
                                        .foregroundColor(selectedInterval == interval ? .white : .black)
                                }
                                .frame(width: 77, height: 70)
                            }
                            .background(selectedInterval == interval ? Color.cyan : Color.myFieldsGray)
                            .cornerRadius(12)
                        }
                    }

                    // صف الساعات
                    HStack(spacing: 12) {
                        ForEach(Hourintervals, id: \.self) { interval in
                            Button(action: {
                                selectedInterval = interval * 60  // نخزن بالدقائق
                            }) {
                                VStack {
                                    Text("\(interval)")
                                        .foregroundColor(selectedInterval == interval * 60 ? .white : .cyan)
                                    Text("Hours")
                                        .foregroundColor(selectedInterval == interval * 60 ? .white : .black)
                                }
                                .frame(width: 77, height: 70)
                            }
                            .background(selectedInterval == interval * 60 ? Color.cyan : Color.myFieldsGray)
                            .cornerRadius(12)
                        }
                    }
                }
                .padding(.top, 20)

                Spacer()

                Button("Start") {
                    startNotificationSetup()
                }
                .frame(width: 355, height: 50)
                .background(Color.cyan)
                .foregroundColor(.white)
                .cornerRadius(16)
                .padding(.top, 40)

                NavigationLink(destination: LitersCounting(weight: $weight, p1: p1), isActive: $navigate) {
                    EmptyView()
                }
            }
            .frame(height: 700)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Notification Setup"),
                      message: Text(alertMessage),
                      dismissButton: .default(Text("OK"), action: {
                    if alertMessage == "Notifications scheduled successfully!" {
                        navigate = true
                    }
                }))
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    func startNotificationSetup() {
        guard let interval = selectedInterval else {
            alertMessage = "Please select a notification interval."
            showingAlert = true
            return
        }

        requestNotificationPermission { granted in
            if granted {
                scheduleNotifications(startTime: StartHour, endTime: EndHour, intervalMinutes: interval)
            } else {
                alertMessage = "Notification permission denied."
                showingAlert = true
            }
        }
    }

    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }

    func scheduleNotifications(startTime: Date, endTime: Date, intervalMinutes: Int) {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()

        let calendar = Calendar.current
        let today = Date()
        let startComponents = calendar.dateComponents([.hour, .minute], from: startTime)
        let endComponents = calendar.dateComponents([.hour, .minute], from: endTime)

        guard let startDate = calendar.date(bySettingHour: startComponents.hour ?? 0,
                                            minute: startComponents.minute ?? 0,
                                            second: 0,
                                            of: today),
              let endDate = calendar.date(bySettingHour: endComponents.hour ?? 0,
                                          minute: endComponents.minute ?? 0,
                                          second: 0,
                                          of: today) else {
            alertMessage = "Failed to parse start/end time."
            showingAlert = true
            return
        }

        if endDate <= startDate {
            alertMessage = "End hour must be after Start hour."
            showingAlert = true
            return
        }

        var nextTriggerDate = startDate

        while nextTriggerDate <= endDate {
            let content = UNMutableNotificationContent()
            content.title = "Reminder"
            content.body = "It's time to hydrate!"
            content.sound = .default

            let triggerHour = calendar.component(.hour, from: nextTriggerDate)
            let triggerMinute = calendar.component(.minute, from: nextTriggerDate)

            var dateComponents = DateComponents()
            dateComponents.hour = triggerHour
            dateComponents.minute = triggerMinute

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            center.add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                }
            }

            nextTriggerDate = calendar.date(byAdding: .minute, value: intervalMinutes, to: nextTriggerDate)!
        }

        alertMessage = "Notifications scheduled successfully!"
        showingAlert = true
    }
}


#Preview {
    Notifications(weight: .constant(70),p1: person())
}
