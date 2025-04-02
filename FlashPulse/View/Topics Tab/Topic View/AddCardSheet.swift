//
//  AddCardSheet.swift
//  FlashPulse
//
//  Created by Derek Wang on 2025-03-29.
//\

import SwiftUI
import PhotosUI
import UIKit

struct AddCardSheet: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Environment(Topic.self) var topic: Topic
    
    @State private var date: Date = .now
    @State private var prompt = ""
    @State private var hint = ""
    @State private var answer = ""
    
    @State private var photoPickerItem: PhotosPickerItem? = nil
    @State private var selectedImage: Image? = nil
    @State private var imageData: Data? = nil
    
    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                
                Spacer()
                
                Text(date.formatted(date: .abbreviated, time: .shortened))
                    .font(.headline.bold())
                
                Spacer()
                
                Button("Save") {
                    save()
                    dismiss()
                }
                .disabled(saveButtonDisabled())
                .font(.headline)
                
            }
            .padding(25)
            
            Form {
                Section("Prompt") {
                    TextField("Prompt", text: $prompt, prompt: Text("Prompt of flashcard..."))
                        .font(.title)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                
                Section("Hints if needed...") {
                    VStack {
                        Text("Your Hint...")
                            .font(.title3)
                            .fontDesign(.serif)
                        TextField("Hint", text: $hint, prompt: Text("Hint of flashcard..."))
                            .font(.title)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                    }
                }
                
                Section("Hint Images") {
                    PhotosPicker(selection: $photoPickerItem, matching: .images) {
                        HStack {
                            Circle()
                                .opacity(0.5)
                                .overlay {
                                    Image(systemName: "plus")
                                        .resizable()
                                        .padding()
                                }
                                .frame(width: 50, height: 50)
                            
                            Text("Add Image")
                                .font(.title)
                                .fontWeight(.bold)
                            
                        }
                    }
                    .onChange(of: photoPickerItem) {
                        Task {
                            await fetchImage()
                        }
                    }
                    
                    // Hint Image if there is one...
                    selectedImage
                        .scaledToFit()
                }
                
                
                Section("Answer of the flash card") {
                    VStack {
                        Text("Answer")
                            .font(.title3)
                            .fontDesign(.serif)
                        TextField("Answer", text: $answer, prompt: Text("Answer of the flashcard..."))
                            .font(.title)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
        }
    }
    
    // disables saveButton when prompt or answer is not set to accepted format
    func saveButtonDisabled() -> Bool {
        prompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || answer.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func fetchImage() async {
        if let data = try? await photoPickerItem?.loadTransferable(type: Data.self) {
            imageData = data
            
            guard let uiImage = UIImage(data: data) else { return }
            withAnimation(.easeInOut) {
                selectedImage = Image(uiImage: uiImage)
            }
        }
    }
    
    func save() {
        // create card from the states of the view and insert to Topic's cards array
        let card = Card(timestamp: date, prompt: prompt, hint: hint, hintImageData: imageData, answer: answer)
        topic.cards.insert(card, at: 0)
    }
}

#Preview {
    AddCardSheet()
        .environment(Topic.example)
}
