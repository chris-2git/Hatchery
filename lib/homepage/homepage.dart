import 'package:egg_project/api/homeapi.dart';
import 'package:egg_project/model/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false)
          .profileData(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        return Scaffold(
          body: homeProvider.islOading
              ? const Center(child: CircularProgressIndicator())
              : homeProvider.isError
                  ? const Center(
                      child: Text(
                        'Failed to load farm data. Please try again.',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    )
                  : homeProvider.farms.isEmpty
                      ? const Center(
                          child: Text(
                            'No farm data available.',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListView.builder(
                            itemCount: homeProvider.farms.length,
                            itemBuilder: (context, index) {
                              final farm = homeProvider.farms[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 8.0),
                                child: Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        // Days indicator
                                        CircleAvatar(
                                          backgroundColor:
                                              _getStatusColor(index),
                                          child: Text(
                                            '${farm.intervalDays ?? 0}D',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        // Farm name and statuses
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                farm.farmName ?? 'Unknown Farm',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              // Status tags from feedData
                                              Row(
                                                children:
                                                    _buildStatusTags(farm),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Chiks and Mortality values
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'TC: ${farm.chiks ?? 0}',
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'M: ${farm.mortality ?? 0}',
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
        );
      },
    );
  }

  // Function to determine the color of the days circle based on index (for variety)
  Color _getStatusColor(int index) {
    final colors = [
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.green,
      Colors.blue,
    ];
    return colors[index % colors.length];
  }

  // Function to build status tags from feedData
  List<Widget> _buildStatusTags(Homemodel farm) {
    final feedData = farm.feedData;
    if (feedData == null || feedData.isEmpty) {
      return [];
    }
    return feedData.entries.map<Widget>((entry) {
      return Padding(
        padding: const EdgeInsets.only(right: 3.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${entry.key}: ${entry.value}',
            style: const TextStyle(
              color: Colors.purple,
              fontSize: 12,
            ),
          ),
        ),
      );
    }).toList();
  }
}
