//
//  GridView.swift
//  SwiftUIBootcamp
//
//  Created by Ricky Mafra Moino on 27/12/24.
//

import SwiftUI

struct GridView: View {
    var body: some View {
        Grid {
            GridRow {
                Color.green.opacity(0.5)
                    .gridCellColumns(3)
            }
            GridRow {
                Color.blue.opacity(0.5)
                Color.red.opacity(0.5)
                    .gridCellColumns(2)
            }
            GridRow {
                Color.blue.opacity(0.5)
                Color.red.opacity(0.5)
                Color.orange.opacity(0.5)
            }
            GridRow {
                Color.orange.opacity(0.5)
                    .gridCellColumns(2)
                Color.green.opacity(0.5)
            }
        }
    }
}

#Preview {
    GridView()
}
